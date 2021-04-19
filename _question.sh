function question() {
  local purpose="y/n"
  # Adapt purpose with default answer
  if [ "$2" == "y" ]; then
    purpose="Y/n"
  elif [ "$2" == "n" ]; then
    purpose="y/N"
  fi

  read -p "$1 ($purpose): " answer
  # If answer is empty but default as passed use it
  [[ -z "$answer" && ! -z "$2" ]] && answer=$2

  if echo "$answer" | grep -iq "^y" ;then
      return 0
  elif echo "$answer" | grep -iq "^n"; then
    return 1
  else
      echo "invalid answer, please retry"
      question "$1" $2
  fi
}
