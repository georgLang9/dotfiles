#!/bin/zsh

# Install zsh + oh-my-zsh + powerlevel10k
pacman -S zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

cp ./.zshrc ~/

#=====================================================
# Install wezterm
pacman -S wezterm
cp ./.wezterm.lua ~/

#=====================================================
# Install neovim
pacman -S neovim

# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

rm -rf ~/.config/nvim/.git
sudo pacman -S lazygit

# for telescope:
pacman -S ripgrep
pacman -S fd

cp ./.config/nvim/* ~/

#=====================================================
