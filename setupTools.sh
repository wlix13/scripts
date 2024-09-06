#!/bin/bash

# ----------------------------- #
# Install btop
sudo apt install btop -y
grep -q "alias top='btop'" ~/.zshrc || echo "alias top='btop'" >> ~/.zshrc

# Install batcat
sudo apt install bat -y
grep -q "alias bat='batcat --style=plain'" ~/.zshrc || echo "alias bat='batcat --style=plain'" >> ~/.zshrc

# Install tldr
sudo apt install tldr -y

# Install eza
wget -c https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -O - | tar xz
sudo chmod +x eza
sudo chown root:root eza
sudo mv eza /usr/local/bin/eza
grep -q "alias ls='eza'" ~/.zshrc || echo "alias ls='eza'" >> ~/.zshrc

# ----------------------------- #
# Install neovim
sudo apt install xsel -y

# Check for architecture
if [ "$(uname -m)" = "x86_64" ]; then
    echo "Architecture: x86_64"
    curl -fsSLO --proto "=https" --tlsv1.2 https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod +x nvim.appimage
    ./nvim.appimage --appimage-extract
    sudo mv squashfs-root /usr/bin/nvim-source
    sudo ln -s /usr/bin/nvim-source/AppRun /usr/bin/nvim
    rm nvim.appimage
elif [ "$(uname -m)" = "aarch64" ]; then
    echo "Architecture: aarch64"
    sudo apt install snapd -y
    sudo snap install core
    sudo snap install nvim --classic
    sudo ln -s /snap/bin/nvim /usr/bin/nvim
    rm -rf snap
else
    echo "Architecture: Unknown"
    echo "Exiting..."
    exit 1
fi

# Setup NvChad
rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim
grep -q "alias vim='nvim'" ~/.zshrc || echo "alias vim='nvim'" >> ~/.zshrc
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim

# Fix cursor
echo "" >> ~/.config/nvim/init.lua
cat ./configs/nvim/init.lua >> ~/.config/nvim/init.lua

# Change theme
sed -i "s/onedark/tokyonight/" ~/.config/nvim/lua/chadrc.lua

# ! In new NvChad something changed
# Add plugins support
# sed -i "s/local M = {}/local M = {}\nM.plugins = 'custom.plugins'/" ~/.config/nvim/lua/chadrc.lua
# mkdir -p ~/.config/nvim/lua/custom
# cp ./configs/nvim/plugins.lua ~/.config/nvim/lua/custom/plugins.lua

# echo "--- Plugins options ---" >> ~/.config/nvim/init.lua
# echo "g.suda_smart_edit = 1" >> ~/.config/nvim/init.lua

# ----------------------------- #
# Install tmux from source

sudo apt remove tmux -y
rm -rf ~/.tmux

sudo apt install libevent-dev ncurses-dev build-essential bison pkg-config -y
curl -fsSL --proto "=https" --tlsv1.2 https://github.com/tmux/tmux/releases/download/3.3a/tmux-3.3a.tar.gz --output tmux.tar.gz
tar -zxf tmux.tar.gz && rm -f tmux.tar.gz
cd tmux-*/
./configure
make -j$(nproc) && sudo make install
cd .. && rm -rf tmux-*

# Install TPM(Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
mkdir -p ~/.config/tmux

# Setup TPM config
cp ./configs/tmux/tmux.conf ~/.config/tmux/tmux.conf

echo "Done! Run 'tmux' to start tmux and press 'prefix + I' to install plugins."
