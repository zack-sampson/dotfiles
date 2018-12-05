fpath=(~/.zsh.d/functions/context-management $fpath)

if [ -f $HOME/bin/get-directory-for-context ]; then
  function c {
    local dir=$($HOME/bin/get-directory-for-context "$@")
    if [ -n "${dir}" ] ; then
      cd ${dir}
    fi
  } 
fi
