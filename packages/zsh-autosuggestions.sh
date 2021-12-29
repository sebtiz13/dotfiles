#!/usr/bin/env bash

installDir=$ZSH_CUSTOM/plugins/zsh-autosuggestions
function zsh-autosuggestions::_download () {
  sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git $installDir
}

function zsh-autosuggestions::install() {
  # Ask if want install skip if respond no
  question "Do you want install zsh-autosuggestions ?" y || return

  zsh-autosuggestions::_download
}

function zsh-autosuggestions::update() {
  # skip if is installed by package
  checkPackage zsh-autosuggestions && return
  # Skip if is not installed
  [ -d $installDir ] || return
  # Ask if want update skip if respond no
  question "Do you want update zsh-autosuggestions ?" y || return

  zsh-autosuggestions::_download
}
