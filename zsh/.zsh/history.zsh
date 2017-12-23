# largely stolen from oh-my-zsh

if [ -z "$HISTFILE" ]; then
    HISTFILE=$HOME/.zsh_history
fi

HISTSIZE=10000
SAVEHIST=10000

case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='fc -fl 1' ;;
  "dd.mm.yyyy") alias history='fc -El 1' ;;
  "yyyy-mm-dd") alias history='fc =il 1' ;;
  *) alias history='fc -l 1' ;;
esac

# share history across all sessions
setopt SHARE_HISTORY

# don't record lots of redundant shit in history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# add timestamp and duration to history
setopt EXTENDED_HISTORY

# let me edit the history command before executing it
setopt HIST_VERIFY

# append to history in real time
setopt INC_APPEND_HISTORY

setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST

