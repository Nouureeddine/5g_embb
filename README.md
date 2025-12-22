# 5G eMBB Project

This repository contains three OMNeT++/Simu5G simulation scenarios: `5g`, `5g_mec`, and `lte`. Each scenario demonstrates the evolution of mobile networks, highlighting their unique features, configurations, and use cases. Below is a detailed overview and comparison.

---

## Simulation Scenarios

### 1. LTE Network Simulation (`lte/`)
- **Purpose**: Baseline for 4G LTE performance.
- **Key Features**:
  - **Architecture**: Centralized (Server → PGW → eNodeB → UE).
  - **Traffic**: Downlink video streaming (1000B packets @ 10ms intervals).
  - **Performance**: ~800 Kbps per UE, ~64 Mbps total.
  - **Handover**: Enabled (dynamic cell association).
- **Use Case**: General mobile broadband, video streaming.
- **How to Run**:
  1. Place files as per `readme.txt`.
  2. Select configuration: `Scaled_Up_Traffic`.
  3. Run simulation via OMNeT++ IDE or command line.

### 2. 5G Standalone Network Simulation (`5g/`)
- **Purpose**: High-throughput stress testing with 5G NR.
- **Key Features**:
  - **Architecture**: Centralized 5G core (Server → UPF → gNodeB → UE).
  - **Traffic**: Downlink CBR (1400B packets @ 1ms intervals).
  - **Performance**: ~11.2 Mbps per UE, ~896 Mbps total (14x LTE).
  - **Handover**: Disabled (static cell assignment).
- **Use Case**: Bandwidth-intensive tasks, eMBB stress testing.
- **How to Run**:
  1. Place files as per `readme.txt`.
  2. Select configuration: `FiveG_CBR_Stress_Test`.
  3. Run simulation via OMNeT++ IDE or command line.

### 3. 5G MEC Network Simulation (`5g_mec/`)
- **Purpose**: Low-latency edge computing with dynamic app deployment.
- **Key Features**:
  - **Architecture**: Distributed edge (UE → gNodeB → UPF → MEC Host).
  - **Traffic**: Uplink WarningAlertApp (1400B packets @ 1ms intervals).
  - **Performance**: ~11.2 Mbps per UE, ~896 Mbps total.
  - **Handover**: Enabled (dynamic cell association).
  - **MEC Features**: Dynamic app deployment, load balancing, LocationService dependency.
- **Use Case**: Low-latency applications, location-aware services.
- **How to Run**:
  1. Place files as per `readme.txt`.
  2. Select configuration: `MySimulation`.
  3. Run simulation via OMNeT++ IDE or command line.

---

## Comparison Table

| Feature                | LTE                  | 5G Standalone        | 5G MEC               |
|------------------------|----------------------|----------------------|----------------------|
| **Core Network**       | PGW                  | UPF                  | UPF + MEC Hosts      |
| **Base Station**       | eNodeB              | gNodeB               | gNodeB               |
| **User Equipment**     | LteUe               | NrUe                 | NrUe                 |
| **Frequency**          | Default LTE         | 3.5 GHz (mid-band)   | 2 GHz (sub-6 GHz)    |
| **Traffic Direction**  | Downlink            | Downlink             | Uplink               |
| **Traffic Type**       | Video Streaming     | CBR Stress Test      | WarningAlertApp      |
| **App Deployment**     | Static              | Static               | Dynamic (Orchestrator) |
| **Per-UE Rate**        | ~800 Kbps           | ~11.2 Mbps           | ~11.2 Mbps           |
| **Total Load**         | ~64 Mbps            | ~896 Mbps            | ~896 Mbps            |
| **Handover**           | Enabled             | Disabled             | Enabled              |
| **Edge Computing**     | No                  | No                   | Yes                  |
| **Latency**            | High                | Medium               | Low                  |

---

## Key Insights

1. **Performance Evolution**:
   - LTE: ~800 Kbps per UE (baseline).
   - 5G Standalone: ~11.2 Mbps per UE (14x LTE).
   - 5G MEC: Same throughput as 5G Standalone, but with lower latency.

2. **Architecture Evolution**:
   - LTE: Centralized (Server → Core → RAN → UE).
   - 5G Standalone: Centralized 5G core (Server → UPF → gNB → UE).
   - 5G MEC: Distributed edge (UE → gNB → UPF → MEC Host).

3. **Use Case Progression**:
   - LTE: General mobile broadband, video streaming.
   - 5G Standalone: High-throughput applications, bandwidth-intensive tasks.
   - 5G MEC: Low-latency applications, location-aware services, real-time processing.

4. **Key Innovations**:
   - 5G Standalone: Higher throughput, new radio (NR), 5G core (UPF).
   - 5G MEC: Edge computing, dynamic deployment, service orchestration, lower latency.

5. **Trade-offs**:
   - 5G Standalone: Higher throughput, but still centralized (higher latency).
   - 5G MEC: Lower latency, but adds complexity (orchestration, load balancing, service dependencies).

---

## Conclusion

These simulations demonstrate the evolution from LTE to 5G and the benefits of edge computing for latency-sensitive applications. While 5G Standalone offers significant throughput improvements, 5G MEC introduces edge computing to reduce latency and enable advanced use cases like location-aware services. Together, they highlight the transformative potential of 5G technologies.