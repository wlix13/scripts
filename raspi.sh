#!/bin/bash

apt update && apt upgrade -y && apt autoremove -y && apt autoclean -y
apt install sudo wpasupplicant -y

# Create user
read -p "Username: " USERNAME
adduser $USERNAME
usermod -aG sudo $USERNAME

# Change hostname
read -p "Hostname: " HOSTNAME
echo $HOSTNAME > /etc/hostname
echo "127.0.0.1 $HOSTNAME" >> /etc/hosts

# Wi-Fi credentials input
read -p "Wi-Fi SSID: " SSID
read -p "Wi-Fi Passphrase: " PSK

# Create a wpa_supplicant.conf file
cp ./configs/etc/wpa_supplicant.conf /etc/wpa_supplicant.conf
sed -i "0,/ssid/s/ssid=/ssid=$SSID/" /etc/wpa_supplicant.conf
sed -i "0,/psk/s/psk=/psk=$PSK/" /etc/wpa_supplicant.conf

# wpa_supplicant.service
cp ./configs/etc/systemd/system/wpa_supplicant.service /etc/systemd/system/wpa_supplicant.service

# dhclient.service
cp ./configs/etc/systemd/system/dhclient.service /etc/systemd/system/dhclient.service

# Enable services
systemctl daemon-reload
systemctl enable wpa_supplicant.service
systemctl enable dhclient.service

# Create a script to display temperature
sudo touch /usr/local/bin/temp
echo '#!/bin/bash' | sudo tee -a /usr/local/bin/temp
echo "paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\t' -t | sed 's/\(.\)..$/.\1°C/'" | sudo tee -a /usr/local/bin/temp
sudo chmod +x /usr/local/bin/temp
