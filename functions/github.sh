function _latestdata() {
  [ -z "$1" ] && { echo "empty parameter"; exit 1; }

  local field='tag_name'
  [ ! -z "$2" ] && field=$2

  curl --silent "https://api.github.com/repos/$1/releases/latest" | grep -Po '"'$field'": "\K.*?(?=")'
}

function github::lastVersion() {
  [ -z "$1" ] && { echo "empty parameter"; return; }
  _latestdata $1
}

function github::lastDownload() {
  _latestdata $1 "tarball_url"
}

function github::repoTarball() {
  [ -z "$1" ] && { echo "empty parameter"; return; }
  local url="https://api.github.com/repos/$1/tarball"

  [ ! -z "$2" ] && url=$url/$2

  echo $url;
}

function github::gist() {
  [ -z "$1" ] && { echo "empty parameter"; return; }
  local code=$(echo "$1" | sed "s/https:\/\/gist.github.com\///")

  echo https://gist.githubusercontent.com/$code/raw
}
