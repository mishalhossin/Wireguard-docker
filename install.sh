#!/bin/bash

# Update package lists and upgrade packages
sudo apt-get update && sudo apt-get upgrade -y

# Install WireGuard
sudo apt-get install -y wireguard

# Generate private and public keys for the server
umask 077
wg genkey | tee /etc/wireguard/privatekey | wg pubkey > /etc/wireguard/publickey

# Generate private and public keys for the client
wg genkey | tee client_privatekey | wg pubkey > client_publickey

# Create the WireGuard configuration file for the server
cat << EOF > /etc/wireguard/wg0.conf
[Interface]
Address = 10.0.0.1/24
ListenPort = 51820
PrivateKey = $(cat /etc/wireguard/privatekey)

[Peer]
PublicKey = $(cat client_publickey)
AllowedIPs = 10.0.0.2/32
EOF

# Create the WireGuard configuration file for the client
cat << EOF > wg0-client.conf
[Interface]
Address = 10.0.0.2/24
PrivateKey = $(cat client_privatekey)

[Peer]
PublicKey = $(cat /etc/wireguard/publickey)
Endpoint = SERVER_PUBLIC_IP:51820
AllowedIPs = 0.0.0.0/0, ::/0 
EOF

echo "Client configuration saved to wg0-client.conf"

# Enable IP forwarding on the server
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

# Start the WireGuard interface and enable it to start on boot
sudo wg-quick up wg0 && sudo systemctl enable wg-quick@wg0.service

echo "WireGuard server installed successfully!"
