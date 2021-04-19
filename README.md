It's my personnal setup script to deploy the same configuration on all my environments

# Setup

Setup tested on:

* Manjaro 21.0
* 🚧 ~~Debian Buster~~ (todo)
* 🚧 ~~macOs Big Sur~~ (todo)

# Usage

## Install + configure

Full install

`./install.sh`

Install only certain packages

`./install.sh "asdf powerlevel10k"`

## Only configure

Configure all

`./configure.sh`

Configure only certain packages

`./configure.sh "asdf powerlevel10k"`

# Dependencies

* [zsh](https://www.zsh.org/) (Default shell)
* [tree](http://mama.indstate.edu/users/ice/tree/)
* [asdf](https://asdf-vm.com/) (Version manager for multiples languages)
* [powerlevel10k](https://github.com/romkatv/powerlevel10k) (Shell theme)
* [nerd-fonts-noto-sans-mono](https://github.com/ryanoasis/nerd-fonts)
* [delta](https://github.com/dandavison/delta) (A viewer for git and diff output)
* [fzf](https://github.com/junegunn/fzf) (Fuzzy finder)
* [forgit](https://github.com/wfxr/forgit) (Depend of fzf)

## ZSH dependencies

* [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
* [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
* [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
* [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
