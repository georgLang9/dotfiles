#!/bin/bash

SHORT=i:,h
LONG=install:,help
OPTS=$(getopt --alternative --name install --options $SHORT --longoptions $LONG -- "$@")

# Initialize flags
INSTALL_ALL=false
INSTALL_ZSH=false
INSTALL_WEZTERM=false
INSTALL_NEOVIM=false
INSTALL_FONTS=false
INSTALL_HYPRLAND=false
INSTALL_DEMACS=false
VALID_ARGUMENTS=$#

INSTALL_DIR = $(pwd)

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
	fonts)
		INSTALL_FONTS=true
		;;
	hyprland)
		INSTALL_HYPRLAND=true
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
	install_fonts
	install_hyprland
}

# Install zsh + oh-my-zsh + powerlevel10k
install_zsh() {
	install_rust
	echo "Installing zsh"
	sudo pacman -S --needed zsh

	echo "Installing oh-my-zsh"
	cp -r ./dotfiles/oh-my-zsh/ ~/.oh-my-zsh/

	# powerlevel10k
	echo "Installing powerlevel10k"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

	# zsh plugins
	echo "Installing plugins..."
	git clone https://github.com/zsh-users/zsh-autosuggestions.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom/}/plugins/zsh-autosuggestions"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom/}/plugins/zsh-syntax-highlighting"
	git clone https://github.com/zdharma-continuum/fast-syntax-highlighting "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting"
	git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom/}/plugins/zsh-autocomplete"

	# copy config
	cp ./dotfiles/zshrc ~/.zshrc
}

#=====================================================
# Install wezterm
install_wezterm() {
	echo "Installing wezterm..."
	sudo pacman -S wezterm

	#=====================================================
	# Color themes

	# Oxocarbon
	mkdir -p $HOME/.config/wezterm
	mkdir -p $HOME/.config/wezterm/colors
	cd $HOME/.config/wezterm/colors/
	curl -O https://raw.githubusercontent.com/nyoom-engineering/oxocarbon-wezterm/main/oxocarbon-dark.toml
	cd "$INSTALL_DIR" # Go back do install folder

	# copy config
	cp -r ./.config/wezterm/ ~/.config/wezterm/
}

#=====================================================
# Install fonts
install_fonts() {
	echo "Installing fonts..."
	sudo pacman -S --needed otf-droid-nerd ttf-jetbrains-mono-nerd ttf-firacode-nerd

	# SFMono Nerd Font
	git clone https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized.git && cd SFMono-Nerd-Font-Ligaturized
	cp -p *.otf ~/.local/share/fonts

	cd "$INSTALL_DIR"
	rm -rf SFMono-Nerd-Font-Ligaturized # cleanup
}

# Install neovim
install_neovim() {
	echo "Installing neovim..."
	sudo pacman -S --needed neovim lazygit ripgrep fd
	echo "Done installing neovim"

	echo "Installing lazyvim distro..."
	sudo rm -rf ~/.config/nvim/
	git clone https://github.com/LazyVim/starter ~/.config/nvim
	echo "Done installing lazyvim"

	# remove local git
	echo "Remove .git folder in config..."
	rm -rf ~/.config/nvim/.git

	echo "updating config..."
	cp -r ./dotfiles/nvim ~/.config/nvim

}

#=====================================================
# hyprland
install_hyprland() {
	sudo pacman -Syu

	# hyprland and utilities
	sudo pacman -S --needed dunst pipewire wireplumber \
		xdg-desktop-portal-hyprland polkit-kde-agent \
		qt5-wayland qt6-wayland wlroots sddm rofi
	yay -S hyprland-git

	# replace old config with new one
	rm -rf ~/.config/hypr/
	cp -r ./dotfiles//hypr/ ~/.config/hypr/
}

install_rust() {
	echo "Installing rust..."
	if command -v rustup --version &>/dev/null; then
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

if [ "$INSTALL_FONTS" = true ]; then
	install_fonts
fi

if [ "$INSTALL_HYPRLAND" = true ]; then
	install_hyprland
fi

if [ "$INSTALL_DEMACS" = true ]; then
	install_dEmacs
fi
