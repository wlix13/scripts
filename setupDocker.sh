#!/bin/bash

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y

# Add gvisor repository
curl -fsSL https://gvisor.dev/archive.key | sudo gpg --dearmor -o /usr/share/keyrings/gvisor-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/gvisor-archive-keyring.gpg] https://storage.googleapis.com/gvisor/releases release main" | sudo tee /etc/apt/sources.list.d/gvisor.list > /dev/null

# Download docker script
curl -fsSL --proto "=https" --tlsv1.2 https://get.docker.com -o get-docker.sh

# Install docker
sudo sh get-docker.sh && rm -rf get-docker.sh

# Install docker-compose
sudo apt install docker-compose -y

# Add user to docker group
sudo usermod -aG docker $(whoami)

# Install gvisor
sudo apt update && sudo apt install runsc -y
