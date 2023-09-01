#!/bin/sh
mkdir -p ~/.src
cd ~/.src

git clone https://aur.archlinux.org/cwm.git
git clone https://aur.archlinux.org/skypeforlinux-stable-bin.git
git clone https://aur.archlinux.org/nordvpn-bin.git
git clone https://aur.archlinux.org/tor-browser.git 
git clone https://aur.archlinux.org/zoom.git
git clone https://aur.archlinux.org/nvidia-470xx-utils.git
git clone https://aur.archlinux.org/lib32-nvidia-470xx-utils.git
git clone https://aur.archlinux.org/protontricks.git

cd ~/.src/cwm
makepkg -si

cd ~/.src/skypeforlinux-stable-bin
makepkg -si

cd ~/.src/nordvpn-bin
makepkg -si

gpg --auto-key-locate nodefault,wkd --locate-keys torbrowser@torproject.org 
cd ~/.src/tor-browser
makepkg -si 

cd ~/.src/zoom
makepkg -si 

cd ~/.src/nvidia-470xx-utils
makepkg -si

cd ~/.src/lib32-nvidia-470xx-utils
makepkg -si

cd ~/.src/protontricks
makepkg -si 

cd
rm -rf ~/.src/*
