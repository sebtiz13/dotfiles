source $(dirname $0)/asdf.sh

# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
}
