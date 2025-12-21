package simu5g.simulations.lte.networks;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.networklayer.ipv4.RoutingTableRecorder;
import inet.node.ethernet.Eth10G;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import simu5g.common.binder.Binder;
import simu5g.common.carrierAggregation.CarrierAggregation;
import simu5g.nodes.PgwStandard;
import simu5g.nodes.LteUe;
import simu5g.nodes.eNodeB;
import simu5g.world.radio.LteChannelControl;

network mymapp
{
    parameters:
        // Set Default to 80 (20 users * 4 towers)
        int numUe = default(80); 
        @display("i=block/network2;bgb=1000,600;bgi=background/budapest");

    submodules:
        channelControl: LteChannelControl { @display("p=50,25"); }
        routingRecorder: RoutingTableRecorder { @display("p=50,75"); }
        configurator: Ipv4NetworkConfigurator { @display("p=50,125"); }
        binder: Binder { @display("p=50,175"); }
        carrierAggregation: CarrierAggregation { @display("p=50,258"); }

        // Core Network
        server: StandardHost { @display("p=500,50;i=device/server"); }
        centralRouter: Router { @display("p=500,150;i=device/smallrouter"); }
        pgw: PgwStandard { @display("p=500,250;is=l"); }

        // 4 Towers
        eNodeB1: eNodeB { @display("p=100,400;is=vl"); }
        eNodeB2: eNodeB { @display("p=300,400;is=vl"); }
        eNodeB3: eNodeB { @display("p=700,400;is=vl"); }
        eNodeB4: eNodeB { @display("p=900,400;is=vl"); }

        // --- SCALABLE UEs ---
        // This single line creates 80 users automatically (ue[0] to ue[79])
        ue[numUe]: LteUe { 
            @display("p=500,500"); 
        }

    connections:
        server.pppg++ <--> Eth10G <--> centralRouter.pppg++;
        centralRouter.pppg++ <--> Eth10G <--> pgw.filterGate;

        pgw.pppg++ <--> Eth10G <--> eNodeB1.ppp;
        pgw.pppg++ <--> Eth10G <--> eNodeB2.ppp;
        pgw.pppg++ <--> Eth10G <--> eNodeB3.ppp;
        pgw.pppg++ <--> Eth10G <--> eNodeB4.ppp;

        eNodeB1.x2++ <--> Eth10G <--> eNodeB2.x2++;
        eNodeB3.x2++ <--> Eth10G <--> eNodeB4.x2++;
}