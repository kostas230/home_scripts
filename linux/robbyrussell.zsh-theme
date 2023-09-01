PROMPT="%D{%f/%m/%y}|%D{%L:%M} %(?:%{$fg_bold[green]%}> :%{$fg_bold[red]%}> )"
PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)
'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}X"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

TMOUT=60

TRAPALRM() { 
	zle reset-prompt
}
