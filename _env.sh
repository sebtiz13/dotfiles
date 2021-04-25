# Set env variables
[ -z "$ZSH" ] && ZSH="/usr/share/oh-my-zsh"

[ -z "$ZSH_CUSTOM" ] && ZSH_CUSTOM="$ZSH/custom"

[ -z "$SHARE_DIR" ] && SHARE_DIR=/usr/share/personal-env

DEFAULT_PACKAGES=$(ls packages/*.sh | sed -e 's/packages\///' -e 's/\.sh$//')
[ -z "$PACKAGES" ] && PACKAGES=$DEFAULT_PACKAGES

[ -z "$DEFAULT_THEME" ] && DEFAULT_THEME="powerlevel10k/powerlevel10k"

[ -z "$DEFAULT_PLUGINS" ] && DEFAULT_PLUGINS=(
  sudo
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

# Load environment dependant installs functions
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  if [ -f "/etc/arch-release" ]; then
    source ./installs/install-arch.sh
  elif [ -f "/etc/debian_version" ]; then
    echo "do implement"
    exit 0
  fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo "do implement"
  exit 0
else
  echo "The os $OSTYPE is not supported"
  exit 1
fi
