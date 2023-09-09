#!/bin/bash

SHORT=i:,h
LONG=install:,help
OPTS=$(getopt --alternative --name install --options $SHORT --longoptions $LONG -- "$@")

# Initialize flags
INSTALL_ALL=false
INSTALL_ZSH=false
INSTALL_WEZTERM=false
INSTALL_NEOVIM=false
INSTALL_HYPRLAND=false
INSTALL_DEMACS=false
VALID_ARGUMENTS=$#

if [ "$VALID_ARGUMENTS" -eq 0 ]; then
	usage
fi

# Process command line options
while [ $# -gt 0 ]; do
	case "$1" in
	-i | --install)
		shift
		;;
	-h | --help)
		usage
		;;
	zsh)
		INSTALL_ZSH=true
		;;
	wezterm)
		INSTALL_WEZTERM=true
		;;
	neovim)
		INSTALL_NEOVIM=true
		;;
	hyprland)
		INSTALL_HYPRLAND=true
		;;
	dEmacs)
		INSTALL_DEMACS=true
		;;
	all)
		INSTALL_ALL=true
		;;
	esac
	shift
done

# Function to display usage information
usage() {
	echo "Usage: $0 [-i | --install] [-h | --help] [component1] [component2] ..."
	exit 2
}

install_all() {
	echo "Installing all..."
	install_zsh
	install_wezterm
	install_neovim
	#install_dEmacs
	install_hyprland
}

# Install zsh + oh-my-zsh + powerlevel10k
install_zsh() {
	install_rust
	echo "Installing zsh"
	sudo pacman -S --needed zsh

	FILE=~/.oh-my-zsh/
	if [ -d "$FILE" ]; then
		echo "oh-my-zsh already installed..."
	else
		echo "Installing oh-my-zsh..."
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	fi

	# powerlevel10k
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

	# zsh plugins
	sudo pacman -S --needed zsh-autosuggestions zsh-syntax-highlighting
	git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
	git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM:-$HOME/plugins/zsh-autocomplete

	# copy config
	cp ./.zshrc ~/
}

#=====================================================
# Install wezterm
install_wezterm() {
	echo "Installing wezterm..."
	sudo pacman -S --needed wezterm otf-droid-nerd ttf-jetbrains-mono-nerd ttf-firacode-nerd

	# copy config
	cp ./.wezterm.lua ~/
}

# Install neovim
install_neovim() {
	echo "Installing neovim..."
	sudo pacman -S --needed neovim lazygit ripgrep fd

	FILE=~/.config/nvim/lua/
	if [ -d "$FILE" ]; then
		echo "lazyvim already installed..."
	else
		# Install lazyvim
		echo "Installing lazyvim..."
		git clone https://github.com/LazyVim/starter ~/.config/nvim

		# remove local git
		rm -rf ~/.config/nvim/.git
	fi

	echo "updating config..."
	cp -r ./.config/nvim/* ~/
}

#=====================================================
# doom emacs
install_dEmacs() {
	echo "Installing doom emacs"
	sudo pacman -S --needed emacs

	FILE=~/.config/emacs/bin/doom
	if [ -f "$FILE" ]; then
		echo "doom emacs already installed..."
	else
		git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
		$FILE install
	fi

	FILE=~/.config/autostart/emacs.desktop
	if [ -f "$FILE" ]; then
		echo "autostart for emacs exists"
	else
		mkdir ~/.config/autostart/
		cp ./emacs.desktop ~/.config/autostart/.
	fi

	doom sync
}

#=====================================================
# hyprland
install_hyprland() {
	sudo pacman -Syu
	install_rust

	sudo pacman -S --needed gtk-layer-shell
	git clone git@github.com:ralismark/eww.git ~/Development/eww/
	git checkout tray-3

	cd ~/Development/eww || exit
	cargo build --release --no-default-features --features=wayland

	# make eww runnable
	cd target/release || exit
	chmod +x ./eww
	cd ~ || exit

	# python dependancies
	yay -S --needed python-pywal python-desktop-entry-lib python-poetry python-build python-pillow

	# normal dependencies
	sudo pacman -S --needed bc blueberry bluez boost boost-libs coreutils curl \
		findutils fish fuzzel fzf gawk gnome-control-center ibus imagemagick \
		libqalculate light networkmanager network-manager-applet nlohmann-json \
		pavucontrol plasma-browser-integration playerctl procps ripgrep socat sox \
		starship udev upower util-linux xorg-xrandr wget wireplumber yad

	# aur packages
	yay -S --needed cava lexend-fonts-git geticons gojq gtklock gtklock-playerctl-module \
		gtklock-powerbar-module gtklock-userinfo-module hyprland-git \
		python-material-color-utilities swww ttf-material-symbols-git wlogout

	echo "Get the following extension: https://addons.mozilla.org/en-US/firefox/addon/plasma-integration/"
	echo "Continue when you got the extension"
	echo "Press any key to continue..."
	read -n 1 -s -r -p "Press any key to continue"

	# for brightness control
	sudo usermod -aG video "$(whoami)"

	# Keyring authentication stuff
	sudo pacman -S --needed gnome-keyring polkit-gnome

	# Utilities
	sudo pacman -S --needed tesseract cliphist grim slurp

	# Install dotfiles from https://github.com/end-4/dots-hyprland/tree/m3ww
	git clone git@github.com:end-4/dots-hyprland.git ~/Development/dots-hyprland
	cd ~/Development/dots-hyprland
	./guided_install.sh

	alias eww="/home/bonesaw/Development/eww/eww"
}

install_rust() {
	echo "Installing rust..."
	if command -v rustc --version &>/dev/null; then
		echo "Rust already installed..."
	else
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
		source "$HOME/.cargo/env"
	fi
}

# Check and install selected components
if [ "$INSTALL_ALL" = true ]; then
	install_all
fi

if [ "$INSTALL_ZSH" = true ]; then
	install_zsh
fi

if [ "$INSTALL_WEZTERM" = true ]; then
	install_wezterm
fi

if [ "$INSTALL_NEOVIM" = true ]; then
	install_neovim
fi

if [ "$INSTALL_HYPRLAND" = true ]; then
	install_hyprland
fi

if [ "$INSTALL_DEMACS" = true ]; then
	install_dEmacs
fi
