#!/bin/bash

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
sudo apt install curl iputils-ping git net-tools dnsutils mtr -y

# Install & configure systemd-resolved
sudo apt install libnss-resolve -y
sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
sudo cp ./configs/etc/systemd/resolved.conf /etc/systemd/resolved.conf

# Setup SSH
# TODO: Use better sed streams
sudo sed -i "s/#Port 22$/Port 22443/" /etc/ssh/sshd_config
sudo sed -i "s/Port 22$/Port 22443/" /etc/ssh/sshd_config
sudo sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
sudo sed -i "s/PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
sudo sed -i "s/#UseDNS no/UseDNS yes/" /etc/ssh/sshd_config
sudo sed -i "s/UseDNS no/UseDNS yes/" /etc/ssh/sshd_config

# Setup Firewall
sudo apt install ufw -y

sudo ufw default deny incoming && sudo ufw default allow outgoing && sudo ufw default allow forward
sudo ufw allow 443
sudo ufw allow 8443
sudo ufw allow 22443
sudo ufw disable && echo y | sudo ufw enable
sudo ufw status verbose

# Add network optimizations
cat ./configs/etc/sysctl.conf | sudo tee -a /etc/sysctl.conf
sudo sysctl --system

# Enable and start systemd-resolved
sudo systemctl enable --now systemd-resolved
sudo systemctl restart systemd-resolved

# Restart SSH
sudo systemctl restart sshd

# If you want to use a VPN, you can use the following commands to skip the VPN for certain ports
# iptables -t mangle -A OUTPUT -p tcp -m multiport --sports 80,8443 -j MARK --set-mark 1
# ip route add default via addr of eth0 eth0 table 100 < gateway > dev
# ip rule add fwmark 1 table 100
