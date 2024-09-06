#!/bin/bash

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
sudo apt install gcc g++ wget unzip git locales jq apt-transport-https ca-certificates gnupg -y

# Install zsh shell
sudo apt install zsh -y
sudo usermod -s /usr/bin/zsh $(whoami)

# Install curl with http2/3 support
CURL_URL=""
if [ "$(uname -m)" = "x86_64" ]; then
    CURL_URL="https://github.com/stunnel/static-curl/releases/download/8.15.0/curl-linux-x86_64-glibc-8.15.0.tar.xz"
elif [ "$(uname -m)" = "aarch64" ]; then
    CURL_URL="https://github.com/stunnel/static-curl/releases/download/8.15.0/curl-linux-aarch64-glibc-8.15.0.tar.xz"
fi

if [ -n "$CURL_URL" ]; then
    wget -c "$CURL_URL" -O - | tar xJ
    chmod +x curl
    sudo mv curl /usr/local/bin/curl
    sudo apt remove curl -y && sudo apt autoremove -y && sudo apt autoclean -y
else
    sudo apt install curl -y
fi

# Install Oh-My-zsh
curl --compressed \
     --retry 3 \
     --retry-connrefused \
     --connect-timeout 10 \
     --max-time 120 \
     --proto '=https' \
     --tlsv1.2 \
     -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Configure
sudo timedatectl set-timezone UTC
sudo sed -i "s/^# *\(en_US.UTF-8\)/\1/" /etc/locale.gen
sudo sed -i "s/^# *\(u_RU.UTF-8\)/\1/" /etc/locale.gen
sudo locale-gen

# Init zsh
mkdir -p ~/.config
zsh && exit
