#!/bin/zsh

set -exuo pipefail

# Create this as a real directory so stow doesn't symlink it
mkdir -p ${HOME}/.config

# Install Homebrew
if ! which brew ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
