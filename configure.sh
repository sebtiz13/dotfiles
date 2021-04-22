#!/usr/bin/env bash
source ./_question.sh
source ./_env.sh

function main() {
  # Ask for the administrator password upfront
  sudo -v

  packagesList=$PACKAGES
  [ ! -z "$1" ] && packagesList=$1

  for package in ${packagesList[@]}; do
    source ./packages/$package.sh
    # Call configure function only if exist
    [ "$(LC_ALL=C type -t $package::configure)" == "function" ] && $package::configure
  done
}

if [ -z "$1" ]; then
  main
else
  configure::packages "$1"
fi
