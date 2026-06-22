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
echo "Starting Unattended Auto-Installation for TDM Version 5 LTS..."
echo "------------------------------------------------------------"

# 
DEB_URL="https://github.com/Superchavo/termux-display-manager-repo/raw/refs/heads/master/termux-dm_5.0-LTS-Support.deb"

# 
echo ""
echo "Installing base repositories and core packages..."
pkg install root-repo x11-repo tur-repo -y && \
apt install xdotool python tigervnc -y && \
apt install libpng libjpeg-turbo build-essential python-tkinter python-pillow -y

#
echo ""
echo "Downloading TDM package..."
DEB_FILE=$(basename "$DEB_URL")
curl -L -o "$DEB_FILE" "$DEB_URL"

#
echo ""
echo "Installing the downloaded .deb package..."
apt install "./$DEB_FILE" -y

echo ""
echo "Auto-Installation completed successfully!"
