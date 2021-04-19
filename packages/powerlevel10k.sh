#!/usr/bin/env bash

function install::powerlevel10k() {
  [ ! -n "$ZSH_CUSTOM" ] && { echo "ZSH_CUSTOM is not set"; exit 1; }

  local installPath=$ZSH_CUSTOM/themes/powerlevel10k
  if [ ! -d $installPath ]; then
    sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $installPath
  fi
}

function configure::powerlevel10k() {
  # If .gitconfig allready exist skip
  [ -f $HOME/.p10k.zsh ] && return

  if question "Do you want configure powerlevel10k ?" n; then
    p10k configure
  else
    cp templates/p10k.zsh $HOME/.p10k.zsh
    sudo cp templates/p10k.zsh /root/.p10k.zsh
  fi
}
