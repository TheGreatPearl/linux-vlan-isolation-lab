# Linux Virtualized VLANs & Inter-VLAN Routing Lab

A complete, automated virtualized networking lab implemented on Ubuntu Linux. This project demonstrates 802.1Q VLAN trunking, Linux bridges, centralized DHCP provisioning via `dnsmasq`, and strict security isolation enforced through `iptables`.

---

## Architecture & Core Components

* **VLAN 10**: `192.168.10.0/24` (Management / Primary Network)
* **VLAN 20**: `192.168.20.0/24` (Isolated / Guest Network)
* **Bridging**: Linux network bridges (`br-vlan10`, `br-vlan20`) bound to 802.1Q sub-interfaces (`enp0s3.10`, `enp0s3.20`).
* **DHCP Services**: Managed by `dnsmasq` configured in DHCP-only mode (`port=0`) to prevent port conflicts with `systemd-resolved`.
* **Security & Firewall**: Strict inter-VLAN isolation enforced using `iptables FORWARD` chain rules (`DROP` policy for direct cross-VLAN traffic).

---

## 🚀 Quick Start (Automated Setup)

You can automatically provision the entire network topology, bridges, and security rules by running the provided automated Bash script.

1. Clone the repository:
