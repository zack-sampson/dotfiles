if ! which fzf >/dev/null 2>&1 ; then
  exit 0
fi

if [ -d $HOME/.nix-profile ] ; then
    source $HOME/.nix-profile/share/fzf/key-bindings.zsh
    source $HOME/.nix-profile/share/fzf/completion.zsh
else
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
fi

# stolen from https://mike.place/2017/fzf-fd/
export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
