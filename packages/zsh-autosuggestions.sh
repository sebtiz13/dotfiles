#!/usr/bin/env bash

function install::zsh-autosuggestions() {
  [ ! -n "$ZSH_CUSTOM" ] && { echo "ZSH_CUSTOM is not set"; exit 1; }

  local installPath=$ZSH_CUSTOM/plugins/zsh-autosuggestions
  if [ ! -d $installPath ]; then
    sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git $installPath
  fi
}
