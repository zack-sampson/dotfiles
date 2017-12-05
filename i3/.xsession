#!/bin/zsh

touch $HOME/ran-xsession

exec $HOME/.nix-profile/bin/i3
