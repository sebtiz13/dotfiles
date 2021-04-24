#!/usr/bin/env bash

if [[ -x "$(command -v xmodmap)" && ! -f $HOME/.Xmodmap ]]; then
  # Apply change on xmodmap
  for expression in "$(grep -o '^[^#]*' templates/xmodmap)"; do
    echo "$expression" >> $HOME/.Xmodmap
    xmodmap -e "$expression"
  done
  # Export full keymap table cause freeze with KDE plasma
  # xmodmap -pke > $HOME/.Xmodmap
elif [ -f $HOME/.Xmodmap ]; then
  echo "$HOME/.Xmodmap already exist"
else
  echo "xmodmap it's not available"
fi
