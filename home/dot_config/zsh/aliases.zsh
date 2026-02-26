# Store relative path of this file
LOCAL_DIR=$(dirname $0)

#------------------
# Improve default commands
#------------------
# confirm before overwriting something
alias cp='cp -i'
alias mv='mv -i'
# human-readable sizes
alias df='df -h'
alias free='free -h'
alias du='du -h'

#------------------
# Replace commands
#------------------
# Replace ls by eza
if [ -x "$(command -v eza)" ]; then
  alias ls='eza $(printf $EZA_OPTIONS)'
  alias l='eza $(printf $EZA_OPTIONS)'
  alias la='eza -la $(printf $EZA_OPTIONS)'
  alias ll='eza -l $(printf $EZA_OPTIONS)'
fi

[[ -x "$(command -v bat)" ]] && alias cat='bat -p --no-pager' # BAT https://github.com/sharkdp/bat
# If jaq is installed but not jq, alias jq to jaq
[[ -x "$(command -v jaq)" && ! -x "$(command -v jq)" ]] && alias jq='jaq' # JAQ https://github.com/01mf02/jaq

#------------------
# Shortcuts
#------------------
[[ -x "$(command -v helm)" ]] && alias h='helm'

source "${LOCAL_DIR}/kubectl.zsh"
