#!/bin/bash

sudo apt install python3-pip
sudo pip3 install ansible

sudo apt install wireguard wireguard-tools
sudo mkdir /etc/wireguard/keys
wg genkey | sudo tee /etc/wireguard/keys/server_private.key | wg pubkey | sudo tee /etc/wireguard/keys/server_public.key

sudo sysctl -w net.ipv4.ip_forward=1
sudo ufw allow 51820/udp

SERVER_PRIVATE_KEY=$(sudo cat /etc/wireguard/keys/server_private.key)

sudo tee /etc/wireguard/net-lab1.conf > /dev/null <<EOF
[Interface]
Address = 10.10.0.1/24
ListenPort = 51820
PrivateKey = ${SERVER_PRIVATE_KEY}

[Peer]
PublicKey = <PUBLIC_KEY>
AllowedIPs = 10.10.0.2/32
EOF