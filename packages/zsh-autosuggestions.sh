#!/usr/bin/env bash

function zsh-autosuggestions::install() {
  # Ask if want install skip if respond no
  question "Do you want install zsh-autosuggestions ?" y || return

  [ ! -n "$ZSH_CUSTOM" ] && { echo "ZSH_CUSTOM is not set"; exit 1; }

  local installPath=$ZSH_CUSTOM/plugins/zsh-autosuggestions
  if [ ! -d $installPath ]; then
    sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git $installPath
  fi
}
