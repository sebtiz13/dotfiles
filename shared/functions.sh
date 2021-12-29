[ -x "$(command -v asdf)" ] && source $(dirname $0)/asdf.sh

# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
}

# Generate random string
function randomStr() {
  local length=$1
  [ -z $length ] && length=32
  head -c 512 /dev/urandom | LC_CTYPE=C tr -cd 'a-zA-Z0-9' | head -c $length
}
