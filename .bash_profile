if [[ -z "$DISPLAY" ]] && [[ $(tty)=/dev/tty1 ]] && [[ ! -n $SSH_CONNECTION ]]; then
  exec startx
  logout
fi
