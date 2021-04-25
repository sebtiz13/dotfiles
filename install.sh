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

      # Install dependencies
      installer papirus-icon-theme kvantum-qt5

      # Patch to fallback
      echo -e "X-KDE-fallbackPackage=org.kde.breeze.desktop\n" >> $dirname/look-and-feel/metadata.desktop
      # Path defaults value for look and feel
      sed -i 's/kvantum/kvantum-dark/' $dirname/look-and-feel/contents/defaults
      sed -i 's/ColorScheme=Nordic/ColorScheme=Nordic-Darker/' $dirname/look-and-feel/contents/defaults
      sed -i 's/candy-icons/Papirus-Dark/' $dirname/look-and-feel/contents/defaults

      sudo mkdir -p /usr/share/aurorae/themes
      sudo cp -r $dirname/aurorae/Nordic /usr/share/aurorae/themes

      sudo mkdir -p /usr/share/color-schemes
      sudo cp -r $dirname/colorschemes/* /usr/share/color-schemes

      sudo mkdir -p /usr/share/plasma/look-and-feel/Nordic
      sudo cp -r $dirname/look-and-feel/* /usr/share/plasma/look-and-feel/Nordic

      # Install KDE theme
      curl -sSL --create-dirs $(github::repoTarball EliverLara/Nordic-kde) -o ./tmp/Nordic-kde.tar.gz
      local dirnameTheme=./tmp/$(tar -tzf tmp/Nordic-kde.tar.gz | head -1 | cut -f1 -d"/")

      sudo mkdir -p /usr/share/plasma/desktoptheme/Nordic
      sudo cp -r $dirnameTheme/* /usr/share/plasma/desktoptheme/Nordic

      # kvantum configuration
      sudo mkdir -p /usr/share/Kvantum
      sudo cp -r $dirname/kvantum/* /usr/share/Kvantum
      kvantummanager --set Nordic-Darker

      # Apply Nordic theme
      lookandfeeltool -a Nordic

      sudo sudo cp -r $dirname/sddm /usr/share/sddm/themes/nordic
      sudo kwriteconfig5 --file /etc/sddm.conf --group Theme --key Current nordic

      # Konsole themes
      sudo cp -r $dirname/konsole /usr/share
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
  local sharedDir=/usr/share/personal-env

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
