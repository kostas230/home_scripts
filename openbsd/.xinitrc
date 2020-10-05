setxkbmap -layout us,gr -option grp:win_space_toggle &
xrdb -merge ~/.Xresources &
feh --bg-scale ~/Pictures/Wallpapers/wallpaper.jpg &
telegram-desktop &
xscreensaver -no-splash &
urxvtd -q -o -f &
sleep 5 ; xclock -geometry 1366x40+0+0 -digital -update 0.5 -strftime "Arch $(uname -sr) | %A %d %B %y %H:%M:%S | " &
cwm
