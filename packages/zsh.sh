#!/usr/bin/env bash

function zsh::configure() {
  # If .gitconfig allready exist skip
  [ -f $HOME/.zshrc ] && return

  local theme=$DEFAULT_THEME
  echo "Default theme: $DEFAULT_THEME"

  if question "Do you want select an other theme ?" n; then
    local themesPath=( $ZSH/themes $ZSH_CUSTOM/themes )
    local themesList=$(find ${themesPath[@]} -mindepth 1 -maxdepth 2 -name "*.zsh-theme")
    # Remove themesPath from path (cannot use only filename for themes in subdirectories)
    themesList="$(echo "$themesList" | sed -e "s|^${themesPath[0]}/||" -e "s|^${themesPath[1]}/||" -e "s|\.zsh-theme$||")"
    theme=$(echo "$themesList" | fzf --header "Select your theme" --height 100%)
    echo "$theme"
  fi

  # Add space between questions
  echo ""

  local plugins=${DEFAULT_PLUGINS[@]}
  echo "Default plugins: ${DEFAULT_PLUGINS[@]}"

  if question "Do you want customize plugins list ?" n; then
    local pluginsList=$(find $ZSH/plugins $ZSH_CUSTOM/plugins -mindepth 1 -maxdepth 1 -printf "%f\n")
    local _previewPlugin="[ -f $ZSH/plugins/{}/README.md ] && cat $ZSH/plugins/{}/README.md\
     || [ -f $ZSH_CUSTOM/plugins/{}/README.md ] && echo $ZSH_CUSTOM/plugins/{}/README.md || echo 'no README'"

    plugins=$(echo "$pluginsList" | fzf --multi --header "Choose plugins you whant activate" \
      --height 100% \
      --preview "$_previewPlugin" | tr '\n' ' ')
    echo "$plugins"
  fi

  # Need to export the variables for envsubst
  export theme
  export plugins
  # Substitute template variable and output in file
  envsubst '${theme} ${plugins}'< templates/zshrc > .zshrc
  cp .zshrc ~/
  sudo cp .zshrc /root
}
