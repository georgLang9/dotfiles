# !/bin/sh

# update zshrc
cp ~/.zshrc .

# update wezterm
cp ~/.wezterm.lua .

# update i3
cp ~/.config/i3/* .

# update neovim
cp -r ~/.config/nvim/ ./.config/
