#!/bin/zsh
ln -sf ~/.config/home_scripts/linux/xinitrc ~/.xinitrc
ln -sf ~/.config/home_scripts/linux/xinitrc ~/.xsession
ln -sf ~/.config/home_scripts/linux/zprofile ~/.zprofile
ln -sf ~/.config/home_scripts/linux/Xresources ~/.Xresources
ln -sf ~/.config/home_scripts/linux/cwmrc ~/.cwmrc
ln -sf ~/.config/home_scripts/linux/vimrc ~/.vimrc
cp -vfr ~/.config/home_scripts/linux/robbyrussell.zsh-theme ~/.oh-my-zsh/themes/
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
