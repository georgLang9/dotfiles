#!/bin/sh

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
	*)
		echo "Invalid component: $1"
		usage
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
	zsh
	wezterm
	neovim
	hyprland
	dEmacs
}

# Install zsh + oh-my-zsh + powerlevel10k
install_zsh() {
  echo "Installing rust..."
	# install rust
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

  echo "Installing zsh, oh-my-zsh and powerlevel10k..."
	pacman -S zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

	cp ./.zshrc ~/
}

#=====================================================
# Install wezterm
install_wezterm() {
  echo "Installing wezterm..."
	pacman -S wezterm
	cp ./.wezterm.lua ~/
}

#=====================================================
# Install neovim
install_neovim() {
  echo "Installing neovim..."
	pacman -S neovim

  echo "Installing lazyvim..."
	# required
	mv ~/.config/nvim{,.bak}

	# optional but recommended
	mv ~/.local/share/nvim{,.bak}
	mv ~/.local/state/nvim{,.bak}
	mv ~/.cache/nvim{,.bak}

	rm -rf ~/.config/nvim/.git
	sudo pacman -S lazygit

	# for telescope:
	pacman -S ripgrep fd

	cp ./.config/nvim/* ~/
}

#=====================================================
# hyprland
install_hyprland() {
  echo "Installing hyprland..."
	yay -S hyprland-git
	pacman -S sddm dunst pipewire wireplumber xdg-desktop-portal-hyprland polkit-kde-agent qt5-wayland qt6-wayland

  echo "Installing eww..."
	# eww
	git clone https://github.com/elkowar/eww
	cd eww
	cargo build --release --no-default-features --features=wayland
}

#=====================================================
# doom emacs
install_dEmacs() {
  echo "Installing doom emacs"
	pacman -S emacs

	git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
	~/.config/emacs/bin/doom install

	cp ./emacs.desktop ~/.config/autostart/
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
  install_demacs
fi
