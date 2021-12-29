#!/usr/bin/env bash

installDir=$ZSH_CUSTOM/plugins/forgit
function forgit::_download() {
  sudo curl -sSL --create-dirs git.io/forgit -o $installDir/forgit.plugin.zsh
  sudo chmod 755 $installDir
}

function forgit::install() {
  # Ask if want install skip if respond no
  question "Do you want install forgit ?" y || return

  # If fzf is not installed not install forgit
  [ -x "$(command -v fzf)" ] || { echo "forgit need fzf"; return; }

  forgit::_download
}

function forgit::update() {
  # skip if is installed by package
  checkPackage forgit-git && return
  # Skip if is not installed
  [ -d $installDir ] || return
  # Ask if want update skip if respond no
  question "Do you want update forgit ?" y || return

  forgit::_download
}
