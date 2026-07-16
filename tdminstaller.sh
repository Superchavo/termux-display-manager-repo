#!/bin/bash
clear

#
cat << 'ART'
  _____ ____  _        _  _      ____ _____ ____  _     _     _____ ____ 
/__ __Y  _ \/ \__/|  / \/ \  /|/ ___Y__ __Y  _ \/ \   / \   /  __//  __\
  / \ | | \|| |\/||  | || |\ |||    \ / \ | / \|| |   | |   |  \  |  \/|
  | | | |_/|| |  ||  | || | \||\___ | | | | |-||| |_/\| |_/\|  /_ |    /
  \_/ \____/\_/  \|  \_/\_/  \|\____/ \_/ \_/ \|\____/\____/\____\\_/\_\
ART

echo ""

# 
cat << 'MENU'
Please select the TDM version you want to install:
1) Version 1
2) Version 2
3) Version 3.4
4) Version 5 LTS
5) Version 6 LTS (Codenamed Morano)
6) Cancel Installation

MENU

# 
read -p "Enter your choice [1-6]: " version_choice

# 
DEB_URL=""

case $version_choice in
    1)
        echo "Preparing to install TDM Version 1..."
        DEB_URL="https://github.com/Superchavo/termux-display-manager-repo/raw/refs/heads/master/termux-dm-1.0.deb"
        ;;
    2)
        echo "Preparing to install TDM Version 2..."
        DEB_URL="https://github.com/Superchavo/termux-display-manager-repo/raw/refs/heads/master/termux-dm-2.0.deb"
        ;;
    3)
        echo "Preparing to install TDM Version 3.4..."
        DEB_URL="https://github.com/Superchavo/termux-display-manager-repo/raw/refs/heads/master/termux-dm_3.4_all.deb"
        ;;
    4)
        echo "Preparing to install TDM Version 5 LTS..."
        DEB_URL="https://github.com/Superchavo/termux-display-manager-repo/raw/refs/heads/master/termux-dm_5.0-LTS-Support.deb"
        ;;
    5)
        echo "Preparing to install TDM Version 6 LTS (Morano)..."
        DEB_URL="https://github.com/Superchavo/termux-display-manager-repo/raw/refs/heads/master/TermuxDM-v6-LTS-Codenamed-Morano.deb"
        ;;
    6)
        echo "Installation canceled by the user. Exiting."
        exit 0
        ;;
    *)
        echo "Invalid option. Exiting installer."
        exit 1
        ;;
esac

#
echo ""
echo "Installing base repositories and core packages..."
pkg install root-repo x11-repo tur-repo -y && \
apt install xdotool python tigervnc -y && \
apt install libpng libjpeg-turbo build-essential python-tkinter python-pillow -y

echo ""
echo "Downloading TDM package..."
DEB_FILE=$(basename "$DEB_URL")
curl -L -o "$DEB_FILE" "$DEB_URL"

echo ""
echo "Installing the downloaded .deb package..."
apt install "./$DEB_FILE" -y

echo ""
echo "Installation completed successfully!"
