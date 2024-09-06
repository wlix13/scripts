<h2 align="center">Scripts which I use to automate installing and configuring my systems.</h2>

<p align="center">
    <a href="https://github.com/wlix13/scripts/commits/master">
    <img src="https://img.shields.io/github/last-commit/wlix13/scripts.svg?style=flat-square&logo=github&logoColor=white"
         alt="GitHub last commit">
    <a href="https://github.com/wlix13/scripts/issues">
    <img src="https://img.shields.io/github/issues-raw/wlix13/scripts.svg?style=flat-square&logo=github&logoColor=white"
         alt="GitHub issues">
</p>

<p align="center">
  <a href="#about">About</a> •
  <a href="#bash-scripts">Bash scripts</a> •
  <a href="#scripts-description">Description</a> •
  <a href="#usage">Usage</a> •
  <a href="#contributing">Contributing</a>
</p>

# <center>About</center>
This repository contains scripts which I use to automate installing and configuring my systems. I use them to configure my personal computers, servers, and Raspberry Pi. I hope you will find them useful.

## Bash scripts:
1) [setupInit.sh](#setupinit) - Basic configuration of the system
2) [setupPrompt.sh](#setupprompt) - Install Oh-My-Zsh framework with Starship prompt and additional addons
3) [setupTools.sh](#setuptools) - Install different tools with preconfigured settings
4) [setupInet.sh](#setupinet) - Configure network settings
5) [setupDocker.sh](#setupdocker) - Install Docker and Docker Compose
6) [raspi.sh](#raspi) - Automatically configure Raspberry Pi
7) [serverinfo.sh](#serverinfo) - Get information about server on login

# <center>Scripts description</center>

## Bash scripts description:

### Setupinit:
   - Install zsh as default shell
   - Install Oh My Zsh framework and plugins
   - Install additional tools:
     - git
     - gcc
     - g++
     - wget
     - curl
   - Configure locales and timezone

### Setupprompt:
   - Install additional tools:
     - zoxide
     - direnv
     - toilet
   - Install Starship prompt
   - Install FiraCode Nerd Font and enable starship Nerd Font Symbols Preset
   - Enable zsh plugins:
     - git
     - docker
     - autosuggestions
     - syntax-highlighting


### Setuptools:
   - Install additional tools:
     - btop
     - nvim:
       - Download binary for x86_64
       - Install from snap for arm64
     - NvChad:
       - Install nvchad
       - Auto-configure plugins
       - Auto-configure theme
     - Tmux:
       - Build from source
       - Install TPM(Tmux Plugin Manager)
       - Auto-configure plugins

### Setupinet:
   - Install additional tools:
     - curl
     - dnsutils
     - net-tools
     - iputils-ping
     - systemd-resolved
     - ufw
   - Configure systemd-resolved
   - Configure SSH:
     - Change default port
     - Disable password authentication
   - Set up Firewall:
     - Allow HTTPS
     - Allow SSH
   - Add some network optimizations in sysctl.conf

### Raspi:
   - Create user and add it to sudo group
   - Create wpa_supplicant config file
   - Create Wi-Fi services
   - temp command to check temperature of CPU

### Serverinfo:
   - Uptime
   - Memory usage
   - Disk usage
   - Get information about running services(set in script)
   - Docker containers status

## Usage

Don't hesitate to use these scripts. You can use them as you wish. If you have any questions, please contact me.

## Contributing

If you want to contribute to this repository, please contact me. I will be glad to see your pull requests.
