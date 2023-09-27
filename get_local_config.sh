# !/bin/sh

# get local zshrc
cp ~/.zshrc .

# get local wezterm
cp -r ~/.config/wezterm/* ./.config/wezterm/

# get local neovim
cp -r ~/.config/nvim/* ./.config/nvim/

# get local hyprland
cp -r ~/.config/hypr/* ./.config/hypr/

# get local tofi
cp -r ~/.config/tofi/* ./.config/tofi/

# get local waybar
cp -r ~/.config/waybar/* ./.config/waybar/
