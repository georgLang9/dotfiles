# !/bin/sh

# get local zshrc
cp ~/.zshrc .

# get local wezterm
cp ~/.wezterm.lua .

# get local neovim
cp -r ~/.config/nvim/* ./.config/nvim/

# get local hyprland
cp -r ~/.config/hypr/* ./.config/hypr/

# get local tofi
cp -r ~/.config/tofi/* ./.config/tofi/

# get local eww
cp -r ~/.config/eww/* ./.config/eww/
