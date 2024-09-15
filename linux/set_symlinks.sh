#!/bin/sh

ln -sf $HOME/.config/home_scripts/linux/xinitrc $HOME/.xinitrc
ln -sf $HOME/.config/home_scripts/linux/xinitrc $HOME/.xsession
ln -sf $HOME/.config/home_scripts/linux/zprofile $HOME/.zprofile
ln -sf $HOME/.config/home_scripts/linux/Xresources $HOME/.Xresources
ln -sf $HOME/.config/home_scripts/linux/cwmrc $HOME/.cwmrc
ln -sf $HOME/.config/home_scripts/linux/vimrc $HOME/.vimrc
cp -vfr $HOME/.config/home_scripts/linux/robbyrussell.zsh-theme $HOME/.oh-my-zsh/themes/
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
