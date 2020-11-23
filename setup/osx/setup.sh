#!/bin/zsh

set -exuo pipefail

# Create this as a real directory so stow doesn't symlink it
mkdir -p ${HOME}/.config

# Install Homebrew
if ! which brew ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Set default shell to zsh
chsh -s /bin/zsh

HOMEBREW_TARGETS=(
    coreutils
    kakoune
    stow
    fzf
    exa
    ripgrep
    fd
    tig
    jq
    htop
    ranger
    stern
    tree
    k9s
    kubectx
    kubernetes-cli
)

for target in ${HOMEBREW_TARGETS} ; do
    brew install ${target} </dev/null
done

cd ${HOME}/dotfiles
BASIC_STOW_TARGETS=(
    zsh
    context-management
    git
    kak
    stow
    fzf
)

for target in ${BASIC_STOW_TARGETS} ; do
    stow -R ${target}
done

# install jdk
brew cask install adoptopenjdk

