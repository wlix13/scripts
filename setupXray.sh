#!/bin/bash

sudo bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install --beta

sudo systemctl enable --now xray

cur_dir=$(pwd)

cd /usr/local/share/xray
sudo wget -O geoip.dat -N https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat
sudo wget -O geosite.dat -N https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat
sudo wget -O geoip_IR.dat -N https://github.com/chocolate4u/Iran-v2ray-rules/releases/latest/download/geoip.dat
sudo wget -O geosite_IR.dat -N https://github.com/chocolate4u/Iran-v2ray-rules/releases/latest/download/geosite.dat
sudo wget -O geoip_VN.dat https://github.com/vuong2023/vn-v2ray-rules/releases/latest/download/geoip.dat
sudo wget -O geosite_VN.dat https://github.com/vuong2023/vn-v2ray-rules/releases/latest/download/geosite.dat

cd $cur_dir

echo "Please modify '/usr/local/etc/xray/config.json'"
