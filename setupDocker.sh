#!/bin/bash

# Download docker script
curl -fsSL --proto "=https" --tlsv1.2 https://get.docker.com -o get-docker.sh

# Install docker
sudo sh get-docker.sh && rm -rf get-docker.sh

# Install docker-compose
sudo apt install docker-compose -y

# Add user to docker group
sudo usermod -aG docker $(whoami)