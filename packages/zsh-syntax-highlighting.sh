#!/usr/bin/env bash

installDir=$ZSH_CUSTOM/plugins/zsh-syntax-highlighting
function zsh-syntax-highlighting::_download() {
  sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $installPath
}

function zsh-syntax-highlighting::install() {
  # Ask if want install skip if respond no
  question "Do you want install zsh-syntax-highlighting ?" y || return

  zsh-syntax-highlighting::_download
}

function zsh-syntax-highlighting::update() {
  # skip if is installed by package
  checkPackage zsh-syntax-highlighting && return
  # Skip if is not installed
  [ -d $installDir ] || return
  # Ask if want update skip if respond no
  question "Do you want update zsh-syntax-highlighting ?" y || return

  zsh-syntax-highlighting::_download
}
