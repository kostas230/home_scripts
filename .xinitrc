xrdb -merge ~/.Xresources &
exec sh ~/.config/set_wallpaper.sh &
urxvtd -q -o -f &
compton -b &
cwm
