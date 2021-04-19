#!/usr/bin/env bash

if [ -x "$(command -v xmodmap)" ]; then
  # Apply change on xmodmap
  for expression in "$(grep -o '^[^#]*' templates/xmodmap)"; do
    xmodmap -e "$expression"
  done
  xmodmap -pke > $HOME/.Xmodmap
else
  echo "xmodmap it's not available"
fi
