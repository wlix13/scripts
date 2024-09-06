#!/bin/bash

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
sudo apt install gcc g++ wget curl unzip git locales -y

# Install zsh shell
sudo apt install zsh -y
sudo usermod -s /usr/bin/zsh $(whoami)

# Install Oh-My-zsh
curl -fsSL --proto "=https" --tlsv1.2 https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Configure
sudo timedatectl set-timezone Europe/Moscow
sudo sed -i "s/^# *\(en_US.UTF-8\)/\1/" /etc/locale.gen
sudo sed -i "s/^# *\(u_RU.UTF-8\)/\1/" /etc/locale.gen
sudo locale-gen

# Init zsh
mkdir -p ~/.config
zsh && exit
