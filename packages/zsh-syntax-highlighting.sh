#!/usr/bin/env bash

function install::zsh-syntax-highlighting() {
  [ ! -n "$ZSH_CUSTOM" ] && { echo "ZSH_CUSTOM is not set"; exit 1; }

  local installPath=$ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  if [ ! -d $installPath ]; then
    sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $installPath
  fi
}
