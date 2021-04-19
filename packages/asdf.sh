#!/usr/bin/env bash

function install::asdf() {
  if [ -d "/usr/share/asdf" ]; then
    sudo asdf update
  else
    sudo git clone https://github.com/asdf-vm/asdf.git /usr/share/asdf --branch v0.8.0
  fi
}
