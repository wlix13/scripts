#!/bin/bash

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
sudo apt install zoxide direnv fontconfig -y

# Install Starship
curl -fsSL --proto "=https" --tlsv1.2 https://starship.rs/install.sh | sudo sh -s -- -y
sed -i "s/ZSH_THEME=/# ZSH_THEME=/" ~/.zshrc

# Enable oh-my-zsh autoupdate
sudo sed -i "s/^# *\(zstyle ':omz:update' mode auto\)/\1/" ~/.zshrc

# Config for direnv to load dotenv files
mkdir -p ~/.config/direnv
cp ./configs/direnv/direnv.toml ~/.config/direnv/direnv.toml

# Add support for FiraCode Nerd Font
echo "14" | bash -c "$(curl -fsSL https://raw.githubusercontent.com/officialrajdeepsingh/nerd-fonts-installer/main/install.sh)" && rm -rf ~/FiraCode.zip

# Install Nerd Font Symbols Preset
touch ~/.config/starship.toml
curl -fsSL --proto "=https" --tlsv1.2 https://starship.rs/presets/toml/nerd-font-symbols.toml --output ~/.config/starship.toml

# Install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Enable plugins
# TODO: Read from .zshrc and append if not present
# TODO: Make it readable
sed -i "s|plugins=(git)|plugins=(\ngit\nzsh-autosuggestions\ndocker\nzsh-syntax-highlighting\n)\n\n# Completion option-stacking\nzstyle ':completion:*:*:docker:*' option-stacking yes\nzstyle ':completion:*:*:docker-*:*' option-stacking yes|" ~/.zshrc

# Install atuin for better history
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

# Add to .zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc
echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc

echo '# Aliases' >> ~/.zshrc
grep -q "alias tailf='tail -f'" ~/.zshrc || echo "alias tailf='tail -f'" >> ~/.zshrc
grep -q "alias cd='z'" ~/.zshrc || echo "alias cd='z'" >> ~/.zshrc

echo "Done! Please 'source ~/.zshrc' to apply changes."
echo "Also apply 'autoload -U compinit && compinit' to fix zsh compinit issue"
