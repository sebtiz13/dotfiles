#!/usr/bin/env bash

nordicThemeVersion=0112af9
nordicKDEVersion=40c0da3

function desktop::_downloadTheme() {
  local pkg=EliverLara/Nordic
  echo "Install nordic theme (commit: $nordicThemeVersion)"
  [ -d tmp ] || mkdir tmp
  curl -sSL $(github::repoTarball $pkg $nordicThemeVersion) | tar -xzf - -C tmp

  local dirname=tmp/${pkg/\//-}-$nordicThemeVersion

  local gtkTheme=/usr/share/themes/Nordic
  [ -d $gtkTheme ] || sudo mkdir -p $gtkTheme
  sudo cp -r $dirname/assets $gtkTheme
  sudo cp -r $dirname/gtk-2.0 $gtkTheme
  sudo cp -r $dirname/gtk-3.0 $gtkTheme
  sudo cp -r $dirname/index.theme $gtkTheme

  local kdeDir=$dirname/kde
  echo -e "X-KDE-fallbackPackage=org.kde.breeze.desktop\n" >> $kdeDir/plasma/look-and-feel/Nordic/metadata.desktop
  echo -e "X-KDE-fallbackPackage=org.kde.breezedark.desktop\n" >> $kdeDir/plasma/look-and-feel/Nordic-darker/metadata.desktop
  sed -i 's/kvantum/kvantum-dark/' $kdeDir/plasma/look-and-feel/Nordic-darker/contents/defaults
  sed -i 's/candy-icons/Papirus-Dark/' $kdeDir/plasma/look-and-feel/*/contents/defaults

  local lookAndFeel=/usr/share/plasma/look-and-feel
  [ -d $lookAndFeel ] || sudo mkdir -p $lookAndFeel
  sudo cp -r $kdeDir/plasma/look-and-feel/* $lookAndFeel

  local aurorae=/usr/share/aurorae/themes
  [ -d $aurorae ] || sudo mkdir -p $aurorae
  sudo cp -r $kdeDir/aurorae/Nordic $aurorae

  local colorSchemes=/usr/share/color-schemes
  [ -d $colorSchemes ] || sudo mkdir -p $colorSchemes
  sudo cp -r $kdeDir/colorschemes/* $colorSchemes

  local kvantum=/usr/share/Kvantum
  [ -d $kvantum ] || sudo mkdir -p $kvantum
  sudo cp -r $kdeDir/kvantum/* $kvantum

  [ -d /usr/share/konsole ] && sudo cp -r $kdeDir/konsole /usr/share

  [ -d /usr/share/sddm ] && sudo cp -r $kdeDir/sddm /usr/share/sddm/themes/Nordic
}

function desktop::_downloadPlasmaTheme() {
  local pkg=EliverLara/Nordic-kde
  echo "Install nordic KDE (commit: $nordicKDEVersion)"
  [ -d tmp ] || mkdir tmp
  curl -sSL $(github::repoTarball EliverLara/Nordic-kde $nordicKDEVersion) | tar -xzf - -C tmp

  local dirname=tmp/${pkg/\//-}-$nordicKDEVersion
  local desktoptheme=/usr/share/plasma/desktoptheme/Nordic
  [ -d $desktoptheme ] || sudo mkdir -p $desktoptheme
  sudo cp -r $dirname/* $desktoptheme
}

function desktop::_install() {
  desktop::_downloadTheme
  desktop::_downloadPlasmaTheme

  kvantummanager --set Nordic-Darker

  # Apply Nordic theme
  lookandfeeltool -a Nordic-darker

  sudo kwriteconfig5 --file /etc/sddm.conf --group Theme --key Current Nordic

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
}

function desktop::_installGlobalMenu {
  # Install libs to allow to use the global menu widget
  installer libdbusmenu-glib
  cp templates/xprofile $HOME/.xprofile
}

function desktop::install() {
  if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]; then
    question "Do you want install nordic themes ?" n && desktop::_install
    question "Do you want allow global menu ?" n && desktop::_installGlobalMenu
  fi
}

function desktop::update() {
  if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]; then
    question "Do you want update nordic themes ?" n || return

    desktop::_downloadTheme
    desktop::_downloadPlasmaTheme
  fi
}
