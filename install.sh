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
	git clone https://github.com/zsh-users/zsh-autosuggestions.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom/}plugins/zsh-autosuggestions"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom/}plugins/zsh-syntax-highlighting"
	git clone https://github.com/zdharma-continuum/fast-syntax-highlighting "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting"
	git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom/}plugins/zsh-autocomplete"

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

#=====================================================
# Install fonts
install_fonts() {
	echo "Installing fonts..."
	sudo pacman -S --needed otf-droid-nerd ttf-jetbrains-mono-nerd ttf-firacode-nerd

	# SFMono Nerd Font
	git clone https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized.git && cd SFMono-Nerd-Font-Ligaturized
	cp *.otf ~/.local/share/fonts
	cd ~/Development/home-config/       # go back to original folder
	rm -rf SFMono-Nerd-Font-Ligaturized # cleanup
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

	# hyprland and utilities
	sudo pacman -S --needed dunst pipewire wireplumber \
		xdg-desktop-portal-hyprland polkit-kde-agent \
		qt5-wayland qt6-wayland wlroots sddm
	yay -S --needed gdb ninja gcc cmake meson libxcb xcb-proto \
		xcb-util xcb-util-keysyms libxfixes libx11 libxcomposite \
		xorg-xinput libxrender pixman wayland-protocols cairo \
		pango seatd libxkbcommon xcb-util-wm xorg-xwayland \
		libinput libliftoff libdisplay-info cpio

	yay -S --needed tofi
	git clone --recursive https://github.com/hyprwm/Hyprland ~/Apps/hyprland/
	cd ~/Apps/hyprland
	sudo make install

	# eww
	git clone git@github.com:ralismark/eww.git ~/Development/eww/

	cd ~/Development/eww || exit
	cargo build --release --no-default-features --features=wayland

	# make eww runnable
	cd target/release || exit
	chmod +x ./eww
	cp ./eww /usr/local/bin/
	cd ~ || exit

	# delete old config
	rm -rf ~/.config/hypr/
	rm -rf ~/.config/eww/

	cp -r ./.config/nvim/ ~/.config/nvim/
	cp -r ./.config/eww/ ~/.config/eww/
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
