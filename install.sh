#!/usr/bin/env bash
source ./functions/question.sh
source ./functions/github.sh
source ./_env.sh

function install::packages() {
  packagesList=$PACKAGES
  [ ! -z "$1" ] && packagesList=$1

  for package in ${packagesList[@]}; do
    source ./packages/$package.sh
    # Check if install function exist for this package
    [ "$(LC_ALL=C type -t $package::install)" == "function" ] && $package::install
  done
}

function install::themes() {
  if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]; then
    if question "Do you want install nordic themes ?"; then
      curl -sSL --create-dirs $(github::lastDownload EliverLara/Nordic) -o ./tmp/Nordic.tar.gz
      local dirname=./tmp/$(tar -tzf tmp/Nordic.tar.gz | head -1 | cut -f1 -d"/")/kde
      tar -xzf ./tmp/Nordic.tar.gz --directory ./tmp
      sudo kpackagetool5 -g -i $dirname/look-and-feel
      sudo kpackagetool5 -g -i $dirname/aurorae/Nordic
      lookandfeeltool -a Nordic

      sudo pacman -S papirus-icon-theme
      kwriteconfig5 --file $HOME/.config/kdeglobals --group Icons --key Theme Papirus-Dark
      # Legacy configuration
      kwriteconfig5 --file $HOME/.kde4/share/config/kdeglobals --group Icons --key Theme Papirus-Dark

      sudo cp -r $dirname/sddm /usr/share/sddm/themes/nordic
      sudo kwriteconfig5 --file /etc/sddm.conf --group Theme --key Current nordic

      # kvantum dependencies
      sudo pacman -S kvantum-qt5
      cp -r $dirname/kvantum/* $HOME/.config/Kvantum/
      kvantummanager --set Nordic-Darker

      # Konsole themes
      cp -r $dirname/konsole/* $HOME/.local/share/konsole/
      # Copy Nordic profile
      cp templates/konsole-Nordic.profile $HOME/.local/share/konsole/Nordic.profile

      # Apply new profile on first Sessions/windows
      for konsole_service in $(qdbus | grep -iP 'konsole');
      do
        qdbus "$konsole_service" /Sessions/1 setProfile Nordic
        qdbus "$konsole_service" /Windows/1 setDefaultProfile Nordic
      done

      # Save DefaultProfile in ~/.config/konsolerc
      kwriteconfig5 --file $HOME/.config/konsolerc --group Desktop\ Entry --key DefaultProfile "Nordic.profile"
    fi
  fi
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
  install::themes

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
