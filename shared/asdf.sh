# Install one or more versions of specified language
# e.g. `vmi rust` # => fzf multimode, tab to mark, enter to install
# if no plugin is supplied (e.g. `vmi<CR>`), fzf will list them for you
# Mnemonic [V]ersion [M]anager [I]nstall
function vmi() {
  local dataDir=${ASDF_DATA_DIR:-$HOME/.asdf}
  local lang=${1}
  local currentPlugin=( $(ls $dataDir/plugins) )
  local installedVersions=()

  if [[ ! $lang ]]; then
    echo "What plugin you want install ?"
    # use cut to get only the name
    lang=$(asdf plugin list all | fzf | cut -d' ' -f1)
  fi

  if [[ $lang ]]; then
    # if plugin is not already installed
    if [[ " $(echo ${currentPlugin[@]}) " =~ " ${lang} " ]]; then
      local installed=$dataDir/installs/$lang
      [[ -d $installed ]] && installedVersions=( $(ls $installed) )
    else
      asdf plugin add $lang;
    fi

    echo "Please select versions to install (use TAB to select multiple)"
    local versions=( $(asdf list all $lang | fzf --tac --no-sort --multi) )
    if [[ $versions ]]; then
      for version in $versions
        do;
        # if version is not already installed
        if [[ ! " $(echo ${installedVersions[@]}) " =~ " ${version} " ]]; then
          asdf install $lang $version
        fi
      done

      if [[ "${#versions[@]}" -gt 1 ]]; then
        echo "Please select the active version"
        version=$(echo $versions | tr " " "\n" | fzf)
      fi
      asdf global $lang $version
    fi
  fi
}

# Remove one or more versions of specified language
# e.g. `vmi rust` # => fzf multimode, tab to mark, enter to remove
# if no plugin is supplied (e.g. `vmi<CR>`), fzf will list them for you
# Mnemonic [V]ersion [M]anager [C]lean
function vmc() {
  local lang=${1}

  if [[ ! $lang ]]; then
    echo "What plugin you want manage ?"
    lang=$(asdf plugin-list | fzf)
  fi

  if [[ $lang ]]; then
    echo "Please select versions to remove (use TAB to select multiple)"
    local versions=$(asdf list $lang | fzf -multi)
    if [[ $versions ]]; then
      for version in $(echo $versions);
      do; asdf uninstall $lang $version; done;
    fi
  fi
}