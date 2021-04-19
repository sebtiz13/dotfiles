#!/usr/bin/env bash
source ./_question.sh
source ./_env.sh

function install::packages() {
  packagesList=$PACKAGES
  [ ! -z "$1" ] && packagesList=$1

  for package in ${packagesList[@]}; do
    if question "Do you want install $package ?" y; then
      source ./packages/$package.sh
      install::$package
    fi
  done
}

function main() {
  local environment
  local sharedDir=/usr/share/personal-env

  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [ -f "/etc/arch-release" ]; then
      environment="arch"
      source ./installs/install-arch.sh
    elif [ -f "/etc/debian_version" ]; then
      environment="debian"
      echo "do implement"
      exit 0
    fi
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    environment="darwin"
    echo "do implement"
    exit 0
  else
    echo "The os $OSTYPE is not supported"
    exit 1
  fi

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
