#!/bin/bash

RESOLVED_CONF="/etc/systemd/resolved.conf"

# Install cloudflared
if [ "$(uname -m)" = "x86_64" ]; then
    wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && sudo chmod +x cloudflared-linux-amd64 && sudo mv cloudflared-linux-amd64 /usr/bin/cloudflared
elif [ "$(uname -m)" = "aarch64" ]; then
    wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64 && sudo chmod +x cloudflared-linux-arm64 && sudo mv cloudflared-linux-arm64 /usr/bin/cloudflared
else
    echo "Architecture: Unknown"
    echo "Exiting..."
    exit 1
fi

sudo cp ./configs/etc/systemd/system/cloudflare-dns.service /etc/systemd/system/cloudflare-dns.service

sudo systemctl enable --now cloudflare-dns

# Configure systemd-resolved
sudo sed -i 's/^\([[:space:]]*\)DNS=/\1# DNS=/' "$RESOLVED_CONF"
sudo sed -i 's/^\([[:space:]]*\)FallbackDNS=/\1# FallbackDNS=/' "$RESOLVED_CONF"

# Remove all DNS=127.0.0.1:5053 lines
sudo sed -i '/^[[:space:]]*DNS=127.0.0.1:5053[[:space:]]*$/d' "$RESOLVED_CONF"
sudo sed -i '/^[[:space:]]*# DNS=127.0.0.1:5053[[:space:]]*$/d' "$RESOLVED_CONF"

# Insert DNS=127.0.0.1:5053 after the first commented DNS= line, or after [Resolve] if not present
if grep -q '^# DNS=' "$RESOLVED_CONF"; then
    sudo sed -i '/^# DNS=/a DNS=127.0.0.1:5053' "$RESOLVED_CONF"
elif grep -q '^\[Resolve\]' "$RESOLVED_CONF"; then
    sudo sed -i '/^\[Resolve\]/a DNS=127.0.0.1:5053' "$RESOLVED_CONF"
else
    echo "DNS=127.0.0.1:5053" | sudo tee -a "$RESOLVED_CONF" >/dev/null
fi

sudo sed -i 's/^DNSOverTLS=yes$/DNSOverTLS=no/' "$RESOLVED_CONF"

sudo systemctl restart systemd-resolved