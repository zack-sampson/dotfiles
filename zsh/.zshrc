if [ -f ~/zsh/first.zsh ] ; then
  source ~/.zsh/first.zsh
fi

# load from modules in config directory
for config (~/.zsh/*.config.zsh) source $config

if [ -f ~/.zsh/finally.zsh ] ; then
  source ~/.zsh/finally.zsh
fi
