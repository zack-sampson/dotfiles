autoload -Uz compinit

compinit

fpath[1,0]=$HOME/.zsh.d/functions

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zsh/cache

# disable completion of remote git branches"
zstyle ':completion::complete:git-checkout:argument-rest:headrefs' command "git for-each-ref --format='%(refname)' refs/heads 2>/dev/null"

