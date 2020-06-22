export LC_CTYPE="en_US.UTF-8"
setxkbmap -layout us,gr -option grp:win_space_toggle &
xrdb -merge ~/.Xresources &
exec sh ~/.config/set_wallpaper.sh &
urxvtd -q -o -f &
compton -b &
cwm
