#!/bin/zsh
ln -sf ~/.config/home_scripts/openbsd/.xinitrc ~/.xinitrc
ln -sf ~/.config/home_scripts/openbsd/.xinitrc ~/.xsession
ln -sf ~/.config/home_scripts/openbsd/.zprofile ~/.zprofile
ln -sf ~/.config/home_scripts/openbsd/.Xresources ~/.Xresources
ln -sf ~/.config/home_scripts/openbsd/.cwmrc ~/.cwmrc
ln -sf ~/.config/home_scripts/openbsd/.vimrc ~/.vimrc
cp -vfr ~/.config/home_scripts/openbsd/robbyrussell.zsh-theme ~/.oh-my-zsh/themes/
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
mkdir -p ~/Pictures/Wallpapers
cp ~/.config/home_scripts/wallpaper.jpg ~/Pictures/Wallpapers/
