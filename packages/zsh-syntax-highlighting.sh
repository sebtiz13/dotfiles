#!/usr/bin/env bash

function zsh-syntax-highlighting::install() {
  # Ask if want install skip if respond no
  question "Do you want install zsh-syntax-highlighting ?" y || return

  [ ! -n "$ZSH_CUSTOM" ] && { echo "ZSH_CUSTOM is not set"; exit 1; }

  local installPath=$ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  if [ ! -d $installPath ]; then
    sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $installPath
  fi
}
