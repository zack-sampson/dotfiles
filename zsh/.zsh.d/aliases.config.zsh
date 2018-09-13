autoload -Uz compinit
compinit

compdef g='git'

function g() {
  git "$@"
}

# ls aliases
if ! command -v exa >/dev/null ; then
  function ls() {
    ls --color=auto "$@"
  }
  function la() {
    ls -A "$@"
  }
  function ll() {
    ls -l "$@"
  }
  function llh() {
    ls -lh "$@"
  }
  function lla() {
    ls -lA "$@"
  }
  function llah() {
    ls -lAh "$@"
  }
else
  # let's try this out
  # can't use --git because it's too slow with meta
  function ls() {
    exa -la "$@"
  }
  function ll() {
    exa -l "$@"
  }
  function la() {
    exa -a "$@"
  }
  function lla() {
    exa -la "$@"
  }
  # exa is human readable by default
  function llah() {
    exa -la "$@"
  }
fi

function rr() {
  cd $(g rr)
}
