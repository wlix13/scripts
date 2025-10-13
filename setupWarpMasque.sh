#!/bin/bash

USQUE_VERSION="1.4.2"

wget -q https://github.com/Diniboy1123/usque/releases/download/v${USQUE_VERSION}/usque_${USQUE_VERSION}_linux_amd64.zip && \
unzip usque_${USQUE_VERSION}_linux_amd64.zip -d usque

chmod +x usque/usque && sudo mv usque/usque /usr/local/bin/usque && rm -rf usque_${USQUE_VERSION}_linux_amd64.zip usque
sudo mkdir -p /etc/usque

usque enroll -c /etc/usque/config.json && usque register -c /etc/usque/config.json --accept-tos

sudo cp configs/etc/usque/warp-v6-policy.sh /etc/usque/warp-v6-policy.sh && chmod +x /etc/usque/warp-v6-policy.sh
sudo cp configs/etc/systemd/system/cloudflare-warp.service /etc/systemd/system/cloudflare-warp.service
sudo systemctl daemon-reload
sudo systemctl enable --now cloudflare-warp

curl --interface warp https://cloudflare.com/cdn-cgi/trace