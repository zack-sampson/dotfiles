if [ -f ~/zsh.d/first.zsh ] ; then
  source ~/.zsh.d/first.zsh
fi

# load from modules in config directory
for config (~/.zsh.d/*.config.zsh) source $config

if [ -f ~/.zsh.d/finally.zsh ] ; then
  source ~/.zsh.d/finally.zsh
fi
