#!/usr/bin/env bash

function docker::install() {
  # Skip for non arch installation docker-rootless (TODO refactor to support debian)
  [ ! -f "/etc/arch-release" ] && return

  # Ask if want install skip if respond no
  question "Do you want install docker rootless ?" n || return

  installer docker docker-compose docker-rootless-extras-bin
  # Config file
  sudo bash -c "echo "$(whoami):165536:65536" > /etc/subuid"
  sudo bash -c "echo "$(whoami):165536:65536" > /etc/subgid"

  systemctl --user enable --now docker.socket
  systemctl --user start docker.socket
  export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
}
