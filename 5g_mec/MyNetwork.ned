package simu5g.simulations.nr.mec.test_mec;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.networklayer.ipv4.RoutingTableRecorder;
import inet.node.ethernet.Eth10G;
import simu5g.common.binder.Binder;
import simu5g.common.carrierAggregation.CarrierAggregation;
import simu5g.nodes.NrUe;
import simu5g.nodes.gNodeB;
import simu5g.nodes.Upf;
import simu5g.nodes.MecHost;
import simu5g.mec.orchestrator.MecOrchestrator;
import simu5g.mec.ualcmp.Ualcmp;
import simu5g.world.radio.LteChannelControl;

//
// Custom Network with 1 UPF, 4 gNBs, and 2 MEC Hosts
//
network MyNetwork
{
    parameters:
        int numUe = default(1);
        @display("i=block/network2;bgb=1088,678;bgi=background/pisa");
    submodules:
        channelControl: LteChannelControl {
            @display("p=50,25;is=s");
        }
        routingRecorder: RoutingTableRecorder {
            @display("p=50,75;is=s");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=50,125");
        }
        binder: Binder {
            @display("p=50,175;is=s");
        }
        carrierAggregation: CarrierAggregation {
            @display("p=50,258;is=s");
        }
        
        // --- 5G CORE (1 UPF) ---
        upf: Upf {
            @display("p=500,250"); // Central position
        }

        // --- RAN (4 gNBs) ---
        gnb1: gNodeB {
            @display("p=250,400;is=vl");
        }
        gnb2: gNodeB {
            @display("p=750,400;is=vl");
        }
        gnb3: gNodeB {
            @display("p=250,550;is=vl");
        }
        gnb4: gNodeB {
            @display("p=750,550;is=vl");
        }

        // --- UEs ---
        ue[numUe]: NrUe {
            @display("p=500,480");
        }

        // --- MEC MODULES ---
        mecHost1: MecHost {
            @display("p=350,150");
        }
        mecHost2: MecHost {
            @display("p=650,150");
        }
        mecOrchestrator: MecOrchestrator {
            @display("p=250,73");
        }
        ualcmp: Ualcmp {
            @display("p=390,73");
        }

    connections:

        // --- 5G Core / RAN Connections (Star Topology) ---
        // All gNBs connect to the single UPF
        upf.pppg++ <--> Eth10G <--> gnb1.ppp;
        upf.pppg++ <--> Eth10G <--> gnb2.ppp;
        upf.pppg++ <--> Eth10G <--> gnb3.ppp;
        upf.pppg++ <--> Eth10G <--> gnb4.ppp;

        // --- MEC Connections ---
        // UALCMP connects to UPF
        ualcmp.ppp++ <--> Eth10G <--> upf.filterGate;
        ualcmp.toMecOrchestrator --> mecOrchestrator.fromUALCMP;
        ualcmp.fromMecOrchestrator <-- mecOrchestrator.toUALCMP;

        // MEC Hosts connect to the single UPF
        mecHost1.ppp++ <--> Eth10G <--> upf.pppg++;
        mecHost2.ppp++ <--> Eth10G <--> upf.pppg++;

        // --- X2 Connections (Optional Mesh/Ring) ---
        // Connecting neighbors for completeness
        gnb1.x2++ <--> Eth10G <--> gnb2.x2++;
        gnb3.x2++ <--> Eth10G <--> gnb4.x2++;
        gnb1.x2++ <--> Eth10G <--> gnb3.x2++;
        gnb2.x2++ <--> Eth10G <--> gnb4.x2++;
}