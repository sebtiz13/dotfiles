#!/usr/bin/env bash

function git::configure() {
  # If .gitconfig allready exist skip
  [ -f $HOME/.gitconfig ] && return

  if question "Do you want configure your git profiles ?" y; then
    echo -n "Type in your commiter name: "
    read full_name

    echo -n "Type in your email address: "
    read email

    echo -n "What is your default branch (default: main): "
    read defaultBranch
    [ -z "$defaultBranch" ] && defaultBranch="main"

    git config --global user.email $email
    git config --global user.name $full_name
    git config --global init.defaultBranch $defaultBranch

    cat templates/gitconfig >> $HOME/.gitconfig
  fi
}
