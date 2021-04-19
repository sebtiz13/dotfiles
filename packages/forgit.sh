#!/usr/bin/env bash

function install::forgit() {
  # If fzf is not installed not install forgit
  [ -x "$(command -v fzf)" ] || { echo "forgit need fzf"; return; }
  sudo curl -sSL --create-dirs git.io/forgit -o $ZSH_CUSTOM/plugins/forgit/forgit.plugin.zsh
}
