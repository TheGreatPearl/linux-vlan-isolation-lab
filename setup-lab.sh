#!/bin/bash

# 1. Enable IP Forwarding
echo "[*] Enabling IP Forwarding..."
sudo sysctl -w net.ipv4.ip_forward=1

# 2. Setup VLAN 10 & Bridge
echo "[*] Setting up VLAN 10 and br-vlan10..."
sudo ip link add link enp0s3 name enp0s3.10 type vlan id 10 2>/dev/null
sudo ip link set dev enp0s3.10 up
sudo ip link add name br-vlan10 type bridge 2>/dev/null
sudo ip link set dev br-vlan10 up
sudo ip link set dev enp0s3.10 master br-vlan10 2>/dev/null
sudo ip addr add 192.168.10.1/24 dev br-vlan10 2>/dev/null

# 3. Setup VLAN 20 & Bridge
echo "[*] Setting up VLAN 20 and br-vlan20..."
sudo ip link add link enp0s3 name enp0s3.20 type vlan id 20 2>/dev/null
sudo ip link set dev enp0s3.20 up
sudo ip link add name br-vlan20 type bridge 2>/dev/null
sudo ip link set dev br-vlan20 up
sudo ip link set dev enp0s3.20 master br-vlan20 2>/dev/null
sudo ip addr add 192.168.20.1/24 dev br-vlan20 2>/dev/null

# 4. Configure iptables Isolation Rules
echo "[*] Applying iptables inter-VLAN isolation rules..."
sudo iptables -F FORWARD
sudo iptables -A FORWARD -i br-vlan10 -o br-vlan20 -j DROP
sudo iptables -A FORWARD -i br-vlan20 -o br-vlan10 -j DROP
sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

echo "[+] Lab setup completed successfully!"
