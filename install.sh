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
		;;
	esac
	shift
done

USER=$(whoami)

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
	install_dEmacs
	install_hyprland
}

# Install zsh + oh-my-zsh + powerlevel10k
install_zsh() {
	echo "Installing rust..."
  $FILE=/usr/bin/rustup
  if test -f "$FILE"; then
    rustup update
  else 
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  fi

	echo "Installing zsh, oh-my-zsh and powerlevel10k..."
  install_packages zsh

  $FILE=/home/$USER/.oh-my-zsh
  if [ -d "$FILE" ]; then
    echo "oh-my-zsh already installed..."
  else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  $FILE=/home/$USER/.oh-my-zsh/custom/themes/powerlevel10k
  if [ -d "$FILE" ]; then
    echo "powerlevel10k already installed..."
  else
	  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  fi

	cp ./.zshrc /home/$USER/
}

#=====================================================
# Install wezterm
install_wezterm() {
	echo "Installing wezterm..."
  install_packages wezterm

  cp ./.wezterm.lua /home/$USER/
}

#=====================================================
# Install neovim
install_neovim() {
	echo "Installing neovim..."
  install_packages neovim

	# required
	rm /home/$USER/.config/nvim{,.bak}

	# optional but recommended
	rm /home/$USER/.local/share/nvim{,.bak}
	rm /home/$USER/.local/state/nvim{,.bak}
	rm /home/$USER/.cache/nvim{,.bak}

	rm -rf /home/$USER/.config/nvim/.git
  install_packages lazygit

	# for telescope:
  install_packages ripgrep fd

	echo "Installing lazyvim..."
  $FILE=/home/$USER/.config/nvim/lua/
  if [ -d "$FILE" ]; then
    echo "lazyvim already installed..."
  else
    git clone https://github.com/LazyVim/starter /home/$USER/.config/nvim
  fi

  echo "updating config..."
	cp -r ./.config/nvim/* /home/$USER/
}

#=====================================================
# doom emacs
install_dEmacs() {
	echo "Installing doom emacs"
  install_packages emacs 


  $FILE=/home/$USER/.config/emacs/bin/doom
  if [ -f "$FILE" ]; then
    echo "doom emacs already installed..."
  else
	  git clone --depth 1 https://github.com/doomemacs/doomemacs /home/$USER/.config/emacs
    $FILE install
  fi

  $FILE=/home/$USER/.config/autostart/emacs.desktop
  if [ -f "$FILE" ]; then
  else
	  mkdir /home/$USER/.config/autostart/
	  cp ./emacs.desktop /home/$USER/.config/autostart/.
  fi

	doom sync
}

#=====================================================
# hyprland
install_hyprland() {
	echo "Installing hyprland..."
  if pacman -Qs hyprland-git >/dev/null; then
    echo "hyprland-git is already installed..."
  else
    sudo -u $USER yay -S hyprland-git
  fi

  install_packages sddm dunst pipewire wireplumber xdg-desktop-portal-hyprland polkit-kde-agent qt5-wayland qt6-wayland

	echo "Installing eww..."
	# eww
	git clone https://github.com/elkowar/eww
	cd eww
	cargo build --release --no-default-features --features=wayland
}

install_packages() {
  while [ $# -gt 0 ]; do
    if pacman -Qs $1 >/dev/null; then
      echo "$1 is already installed..."
    else
      pacman -S $1
    fi
    shift
    ;;
  done
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
