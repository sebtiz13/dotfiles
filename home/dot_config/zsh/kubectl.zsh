# Exit if kubectl is not installed
[[ -x "$(command -v kubectl)" ]] || return 1

alias k='kubectl'
alias kctx='kubectl config use-context'
alias kns='kubectl config set-context --current --namespace'
