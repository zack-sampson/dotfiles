# if only a directory is entered, CD there
setopt AUTO_CD

# automatically put cd onto pushd stack
setopt AUTO_PUSHD

# don't pwd after pushd/popd
setopt PUSHD_SILENT

# don't push duplicates onto directory stack
setopt PUSHD_IGNORE_DUPS

# something to do with unicode
setopt COMBINING_CHARS

# if autocompleting in a word, don't move cursor to EOL
setopt COMPLETE_IN_WORD

# move to the end of the word after a completion though
setopt ALWAYS_TO_END

# add timestamp and duration to history
setopt EXTENDED_HISTORY

# otherwise ^S and ^Q fuck up the prompt
setopt NO_FLOW_CONTROL

# don't record lots of redundant shit in history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# let me edit the history command before executing it
setopt HIST_VERIFY

# append to history in real time
setopt INC_APPEND_HISTORY

# allow comments (great for copy/paste)
setopt INTERACTIVE_COMMENTS


