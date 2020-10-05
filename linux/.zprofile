if [[ ! $DISPLAY && $XDG_VTNR -eq 1 && ! -n $SSH_CONNECTION ]]; then
  exec startx
  logout
fi
