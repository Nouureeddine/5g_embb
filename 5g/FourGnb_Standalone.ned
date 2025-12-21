package simu5g.simulations.nr.networks;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.networklayer.ipv4.RoutingTableRecorder;
import inet.node.ethernet.Eth10G;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import simu5g.common.binder.Binder;
import simu5g.common.carrierAggregation.CarrierAggregation;
import simu5g.nodes.NrUe;
import simu5g.nodes.gNodeB;
import simu5g.nodes.Upf;
import simu5g.world.radio.LteChannelControl;

network FourGnb_Standalone
{
    parameters:
        int numUe = default(40); // 10 UEs per gNodeB * 4
        @display("i=block/network2;bgb=1100,600;bgi=background/pisa");

    submodules:
        channelControl: LteChannelControl { @display("p=50,25"); }
        routingRecorder: RoutingTableRecorder { @display("p=50,75"); }
        configurator: Ipv4NetworkConfigurator { @display("p=50,125"); }
        binder: Binder { @display("p=50,175"); }
        carrierAggregation: CarrierAggregation { @display("p=50,258"); }

        // --- Core Network (Star Topology) ---
        server: StandardHost { 
            @display("p=500,50;i=device/server"); 
        }
        router: Router { 
            @display("p=500,150;i=device/smallrouter"); 
        }
        upf: Upf { 
            @display("p=500,250;is=l"); 
        }

        // --- 4 gNodeBs ---
        // Spaced out horizontally: X=100, 300, 700, 900
        gnb1: gNodeB { @display("p=100,400;is=vl"); }
        gnb2: gNodeB { @display("p=300,400;is=vl"); }
        gnb3: gNodeB { @display("p=700,400;is=vl"); }
        gnb4: gNodeB { @display("p=900,400;is=vl"); }

        // --- Scalable Users ---
        ue[numUe]: NrUe { 
            @display("p=500,500"); 
        }

    connections:
        // 1. Server -> Router -> UPF
        server.pppg++ <--> Eth10G <--> router.pppg++;
        router.pppg++ <--> Eth10G <--> upf.filterGate;

        // 2. UPF -> All 4 gNodeBs (Direct Connection)
        upf.pppg++ <--> Eth10G <--> gnb1.ppp;
        upf.pppg++ <--> Eth10G <--> gnb2.ppp;
        upf.pppg++ <--> Eth10G <--> gnb3.ppp;
        upf.pppg++ <--> Eth10G <--> gnb4.ppp;

        // 3. Xn (X2) Connections between neighbors
        gnb1.x2++ <--> Eth10G <--> gnb2.x2++;
        gnb2.x2++ <--> Eth10G <--> gnb3.x2++;
        gnb3.x2++ <--> Eth10G <--> gnb4.x2++;
}