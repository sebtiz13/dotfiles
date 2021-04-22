#!/usr/bin/env bash

function forgit::install() {
  # Ask if want install skip if respond no
  question "Do you want install forgit ?" y || return

  # If fzf is not installed not install forgit
  [ -x "$(command -v fzf)" ] || { echo "forgit need fzf"; return; }
  sudo curl -sSL --create-dirs git.io/forgit -o $ZSH_CUSTOM/plugins/forgit/forgit.plugin.zsh
}
