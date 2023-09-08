#!/bin/sh

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

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
# hyprland
yay -S hyprland-git
pacman -S sddm
pacman -S dunst
pacman -S pipewire
pacman -S wireplumber
pacman -S xdg-desktop-portal-hyprland
pacman -S polkit-kde-agent
pacman -S qt5-wayland qt6-wayland

# eww
git clone https://github.com/elkowar/eww
cd eww
cargo build --release --no-default-features --features=wayland

#=====================================================
# doom emacs
pacman -S emacs

git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

cp ./emacs.desktop ~/.config/autostart/
