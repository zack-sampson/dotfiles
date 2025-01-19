autoload -Uz compinit
compinit

compdef g='git'

function g() {
  git "$@"
}

# ls aliases
# use eza if we have it
if ! command -v eza >/dev/null ; then
   # let's try this out
  # can't use --git because it's too slow with meta
  function ls() {
    eza -la "$@"
  }
  function ll() {
    eza -l "$@"
  }
  function la() {
    eza -a "$@"
  }
  function lla() {
    eza -la "$@"
  }
  # eza is human readable by default
  function llah() {
    eza -la "$@"
  }
else
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
fi

function rr() {
  local repositoryRoot=$(g rr 2>/dev/null)
  if [ -n "${repositoryRoot}" ]; then
    cd $(g rev-parse --show-toplevel)
  fi
}
