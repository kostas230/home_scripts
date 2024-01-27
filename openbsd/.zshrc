HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep

zstyle :compinstall filename '/home/kostas230/.zshrc'

autoload -Uz compinit
compinit

export LANG=en_US.UTF-8
export EDITOR='vim'

autoload -U colors && colors

PS1="%{$fg[green]%}%D{%f/%m/%y}%{$reset_color%} | %{fg[green]%}%D{%L:%M}%{$reset_color%} | %{fg[green]%}%d%{$reset_color%} >"
PROMPT+='
'
