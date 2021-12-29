#!/usr/bin/env bash
source ./functions/question.sh
source ./functions/github.sh
source ./_env.sh

function main() {
  # Ask for the administrator password upfront
  sudo -v

  packagesList=$PACKAGES
  [ ! -z "$1" ] && packagesList=$1

  for package in ${packagesList[@]}; do
    source ./packages/$package.sh
    # Call configure function only if exist
    [ "$(LC_ALL=C type -t $package::update)" == "function" ] && $package::update
  done
}

main "$@"
