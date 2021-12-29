#!/usr/bin/env bash

version=v0.8.1
installDir=/opt/asdf-vm
function asdf::_download() {
  local tmpDir=tmp/asdf
  sudo git clone https://github.com/asdf-vm/asdf.git $tmpDir --branch $version

  [ -d $installDir ] || sudo mkdir -p $installDir
  sudo cp -r $tmpDir/bin $installDir
  sudo cp -r $tmpDir/lib $installDir


  local usrshare="/usr/share"
  local docdir="${usrshare}/doc/${pkgname}"
  sudo mkdir -p "${docdir}"

  sudo cp docs/[^_]*.md "${docdir}"
  sudo cp help.txt      "${docdir}"
  sudo cp README.md     "${docdir}"

  # Install completion
  sudo install -Dm644 $tmpDir/completions/asdf.bash "${usrshare}/bash-completion/completions/asdf"
  sudo install -Dm644 $tmpDir/completions/_asdf "${usrshare}/zsh/site-functions/_asdf"
}

function asdf::install() {
  # Ask if want install skip if respond no
  question "Do you want install asdf ?" y || return

  asdf::_download
}

function asdf::update() {
  # skip if is installed by package
  checkPackage asdf-vm && return
  # Skip if is not installed
  [ -d $installDir ] || return

  # Ask if want install skip if respond no
  question "Do you want update asdf ?" y || return

  asdf::_download
}
