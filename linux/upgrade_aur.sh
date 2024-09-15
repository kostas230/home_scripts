#!/bin/sh

mkdir $HOME/.src
cd $/HOME/.src

# Ungoogled Chromium
git clone https://aur.archlinux.org/ungoogled-chromium-bin.git
cd ungoogled-chromium-bin
makepkg -si
cd ..

# 1password 
git clone https://aur.archlinux.org/1password.git
cd 1password
makepkg -si
cd ..

# Mullvad VPN
curl -sS https://mullvad.net/media/mullvad-code-signing.asc | gpg --import
git clone https://aur.archlinux.org/mullvad-vpn-bin.git
cd mullvad-vpn-bin
makepkg -si
cd ..

# EinsteinPy
git clone https://aur.archlinux.org/python-einsteinpy_geodesics.git
cd python-einsteinpy_geodesics
makepkg -si
cd ..

git clone https://aur.archlinux.org/python-einsteinpy.git
cd python-einsteinpy
makepkg -si
cd ..

git clone https://aur.archlinux.org/python-einsteinpy-doc.git
cd python-einsteinpy-doc
makepkg -si
cd ..

# WxMaxima 
gpg --recv-keys 5C86C0E4211D5B8E
git clone https://aur.archlinux.org/wxmaxima.git
cd wxmaxima
makepkg -si
cd ..

# Zoom
git clone https://aur.archlinux.org/zoom.git
cd zoom
makepkg -si
cd ..
