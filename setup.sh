#!/bin/bash

if [whoami -eq "root"]; then
	echo "starting up setup script.."

	apt update -y
	apt upgrade -y

	# install drivers
	ubuntu-drivers install

	# install nessesary programs
	apt install kate kitty krita neovim gimp nomacs fonts-jetbrains-mono steam wget gpg cmake keepassxc git neofetch fonts-paratype flameshot inkscape clang nodejs npm python3 build-essential htop flatpak gnome-software-plugin-flatpak

	# install jetbrains-toolbox
	curl -fsSL https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh | bash

	# install vscode
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
	install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
	sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	rm -f packages.microsoft.gpg

	# setup flatpak
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

	# download nessesary flatpak programs
	flatpak install flathub com.discordapp.Discord org.telegram.desktop com.microsoft.Edge com.obsproject.Studio md.obsidian.obsidian com.github.tchx84.Flatseal io.github.shiftey.Desktop org.blender.Blender

	# dotfile time
	echo "copying dotfiles..."
	cp -r ./dotfiles/* ~/.config/

	echo "system should be setup, reboot reccomended"
else
	echo "use this script in sudo with [sudo ./setup.sh]"
fi
