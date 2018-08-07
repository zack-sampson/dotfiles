# enable hotkey for editing cli in editor
autoload edit-command-line
zle -N edit-command-line

bindkey "^X^X" edit-command-line
