export PATH=$HOME/bin:/usr/local/bin:$PATH

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='kak'
else
  export EDITOR='kak'
fi
