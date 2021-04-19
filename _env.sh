# Set env variables
[ -z "$ZSH" ] && ZSH="/usr/share/oh-my-zsh"

[ -z "$ZSH_CUSTOM" ] && ZSH_CUSTOM="$ZSH/custom"

[ -z "$SHARE_DIR" ] && SHARE_DIR=/usr/share/personal-env

[ -z "$PACKAGES" ] && PACKAGES=$(ls packages | sed -e 's/\.sh$//')

[ -z "$DEFAULT_THEME" ] && DEFAULT_THEME="powerlevel10k/powerlevel10k"

[ -z "$DEFAULT_PLUGINS" ] && DEFAULT_PLUGINS=(
  ssh-agent
  git
  forgit
  git-flow
  fzf
  asdf
  docker
  docker-compose
  npm
  zsh_reload
  zsh-syntax-highlighting
  zsh-autosuggestions
)
