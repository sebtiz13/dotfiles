#!/usr/bin/env bash

function usage() {
    echo "Dotfiles script usage"
    echo ""
    echo "command format  './run.sh install|configure [OPTIONS]'"
    echo "example usage './run.sh install -p \"asdf forgit\"' to only install and configure asdf and forgit packages"
    echo ""
    echo -e " i | install\t\tRun install & configure"
    echo -e " c | configure\t\tOnly run configure"
    echo ""
    echo -e " -p | --packages \"asdf forgit\"\tInstall/configure only certains packages"
    echo ""
}

ARGS=( "$@" )
while (( "$#" )); do
  case "$1" in
    -h|--help)
      usage
      exit
      ;;
    i|install|c|configure)
      [ "$1" = "i" ] || [ "$1" = "install" ] && INSTALL=0
      [ "$1" = "c" ] || [ "$1" = "configure" ] && CONFIGURE=0
      shift
      ;;
    -p|--packages)
      if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
        PACKAGES=$2
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        exit 1
      fi
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
  esac
done

if [ ! -z "$INSTALL" ]; then
  source ./install.sh
elif [ ! -z "$CONFIGURE" ]; then
  source ./configure.sh
else
  echo "What you want to do ?"
  echo ""
  usage
fi

