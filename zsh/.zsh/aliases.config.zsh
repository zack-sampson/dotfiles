autoload -Uz compinit
compinit

compdef g='git'

alias g=git

# ls aliases
if ! command -v exa >/dev/null ; then
  alias ls='ls --color=auto'
  alias la='ls -A'
  alias ll='ls -l'
  alias llh='ls -lh'
  alias lla='ls -lA'
  alias llah='ls -lAh'
else
  # let's try this out
  # can't use --git because it's too slow with meta
  alias ls='exa -la'
  alias ll='exa -l'
  alias la='exa -a'
  alias lla='exa -la'
  # exa is human readable by default
  alias llah='exa -la'
fi

