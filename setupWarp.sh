#!/bin/bash

WGCF_VERSION="2.2.29"

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
sudo apt install wireguard wireguard-tools -y

wget https://github.com/ViRb3/wgcf/releases/download/v${WGCF_VERSION}/wgcf_${WGCF_VERSION}_linux_amd64

chmod +x wgcf_${WGCF_VERSION}_linux_amd64 && sudo mv wgcf_${WGCF_VERSION}_linux_amd64 /usr/local/bin/wgcf

wgcf register --accept-tos
wgcf generate

sed -i '/^DNS = /d' wgcf-profile.conf
sed -i '/^\[Interface\]/a Table = off' wgcf-profile.conf

sudo mv wgcf-profile.conf /etc/wireguard/warp.conf

sudo systemctl enable --now wg-quick@warp

curl --interface warp https://cloudflare.com/cdn-cgi/trace