autoload -Uz compinit

compinit

fpath[1,0]=$HOME/.zsh.d/functions

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zsh/cache
