#!/usr/bin/env bash

function asdf::install() {
  # Ask if want install skip if respond no
  question "Do you want install asdf ?" y || return

  if [ -d "/usr/share/asdf" ]; then
    sudo asdf update
  else
    sudo git clone https://github.com/asdf-vm/asdf.git /usr/share/asdf --branch v0.8.0
  fi
}
