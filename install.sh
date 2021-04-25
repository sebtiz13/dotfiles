#!/usr/bin/env bash
source ./functions/question.sh
source ./functions/github.sh
source ./_env.sh

function install::packages() {
  packagesList=$PACKAGES
  [ ! -z "$1" ] && packagesList=$1

  for package in ${packagesList[@]}; do
    source ./packages/$package.sh
    # Check if install function exist for this package
    [ "$(LC_ALL=C type -t $package::install)" == "function" ] && $package::install
  done
}

function main() {
  local sharedDir=/usr/share/personal-env

  # Ask for the administrator password upfront
  sudo -v

  install::dependencies
  install::shell
  install::packages

  # Create directory for shared dotfiles if not exist
  if [ ! -d "$sharedDir" ]; then
    sudo mkdir -p $sharedDir
    sudo cp shared/* $sharedDir
  fi
}

if [ -z "$1" ]; then
  main
  ./configure.sh
else
  install::packages "$1"
  ./configure.sh "$1"
fi
