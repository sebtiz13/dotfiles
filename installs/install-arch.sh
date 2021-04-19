#!/usr/bin/env bash

function install::dependencies() {
    sudo pacman -S curl zsh oh-my-zsh zsh-theme-powerlevel10k nerd-fonts-noto-sans-mono git unzip fzf tree
    sudo pamac install git-delta-bin
}

function install::shell() {
    for testUser in $USER root; do
        currentShell=$(getent passwd $testUser | awk -F: '{print $NF}')
        [ ! "$currentShell" == "$(which zsh)" ] && sudo usermod -s $(which zsh) $testUser
    done
}