#!/usr/bin/env bash

installDir=$ZSH_CUSTOM/plugins/zsh-autosuggestions
function powerlevel10k::_download() {
  sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $installDir
}

function powerlevel10k::install() {
  # Ask if want install skip if respond no
  question "Do you want install powerlevel10k ?" y || return

  powerlevel10k::_download
}

function powerlevel10k::configure() {
  # If .gitconfig allready exist skip
  [ -f $HOME/.p10k.zsh ] && return

  if question "Do you want configure powerlevel10k ?" n; then
    p10k configure
  else
    cp templates/p10k.zsh $HOME/.p10k.zsh
    sudo cp templates/p10k.zsh /root/.p10k.zsh
  fi
}

function powerlevel10k::update() {
  # Skip if is not installed
  [ -d $installDir ] || return
  # Ask if want update skip if respond no
  question "Do you want update powerlevel10k ?" y || return

  powerlevel10k::_download
}
