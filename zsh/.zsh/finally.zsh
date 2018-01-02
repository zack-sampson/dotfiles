# file to be run after all other config files are run
if command -v tmux >/dev/null ; then
  [[ ! $term =~ screen ]] && [ -z $TMUX ] && exec tmux attach
fi
