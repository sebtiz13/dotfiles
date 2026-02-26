# Dotfiles Repository

This repository contains my personal dotfiles managed using [chezmoi](https://www.chezmoi.io/). Chezmois is a tool for managing dotfiles across multiple machines securely and efficiently.

## Getting Started

### Prerequisites

- `curl` or `wget` (for installing chezmoi)
- `git` (for cloning this repository)

### Installation

To set up your environment using these dotfiles, run the following command:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --purge-binary sebtiz13
```

Or, if you prefer using `wget`:

```sh
sh -c "$(wget -qO- get.chezmoi.io)" -- init --apply --purge-binary sebtiz13
```

### Manual Installation

Alternatively, you can manually install chezmoi and apply the dotfiles:

1. Install chezmoi:
   ```sh
   sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
   ```

2. Clone this repository and apply the dotfiles:
   ```sh
   chezmoi init --apply --purge-binary sebtiz13
   ```

## Environment Setup

This setup includes:

- **ZSH Shell**: A powerful shell with advanced features
- **Sheldon**: A fast and configurable plugin manager for ZSH
- **Powerlevel10k**: A customizable prompt for ZSH
- **FZF**: A fuzzy finder for command-line
- **Mise**: A polyglot runtime manager
- **lessfilter**: A custom filter for `less` to enhance file preview using `eza`, `bat`, and `exiftool`. This is particularly useful for `fzf-tab` preview

### Sheldon Plugins

The following plugins are managed by Sheldon:

- **zsh-defer**: Deferred initialization for faster shell startup
- **zsh-autoswitch-virtualenv**: Automatically switch virtual environments
- **powerlevel10k**: Pretty cool customizable prompt
- **fzf-tab**: Fuzzy tab completion with enhanced preview using `lessfilter`
- **fast-syntax-highlighting**: Syntax highlighting
- **zsh-history-substring-search**: History substring search
- **zsh-autosuggestions**: Command suggestions
- **zsh-completions**: Additional completions
- **fzf**: Fuzzy finder
- **ssh-agent**: SSH agent management
- **zsh-ssh**: SSH utilities

### Mise Tools

The following tools are managed by Mise:

- **chezmoi**: Manage dotfiles across multiple machines
- **flux2**: GitOps tool for Kubernetes
- **mise-completions-sync**: Synchronize shell completions for mise
- **helm**: Kubernetes package manager
- **kubectl**: Kubernetes command-line tool
- **shellcheck**: Shell script analysis tool
- **uv**: Python package installer and resolver

#### Shell Completion

The `mise-completions-sync` tool is used to synchronize shell completion for the mise tool. This ensures that shell completions for tools managed by mise are automatically updated and available in the shell.

### Package Installation

Packages defined in `home/.chezmoidata/packages.yaml` are automatically installed using the script `home/.chezmoiscripts/run_once_before_install-packages.sh.tmpl`. This script enables AUR on pamac, updates sources, and installs the specified packages.

### VSCode Configuration

On macOS and Linux systems, VSCode extensions defined in `home/.chezmoidata/vscode.yaml` are automatically installed using the script `home/.chezmoiscripts/run_onchange_after_configure-vscode.sh.tmpl`. This script installs the specified extensions using the VSCode CLI.

## Dotfiles Structure

- `.config/`: Configuration files for various applications
  - `mise/config.toml`: Mise configuration
  - `sheldon/plugins.tom`: Sheldon plugin manager configuration
  - `git/config.tmpl`: Git configuration template
  - `zsh/`: Custom ZSH configurations
    - `sources/`: Directory for custom fzf-tab sources
      - `command.zsh`: Custom command source
      - `tldr.zsh`: TLDR pages source
    - `.zprofile`: Zsh profile configuration
    - `.zshenv`: Zsh environment configuration
    - `.zshrc`: Zsh runtime configuration
    - `aliases.zsh`: Commands aliases
    - `functions.zsh`: Helper functions
    - `fzf-tab.zsh`: FZF-tab configurations
    - `kubectl.zsh`: kubectl alias
    - `p10k.zsh`: Powerlevel10k configurations
    - `ssh-agent.zsh`: ssh-agent helper (loaded by sheldon with zsh-defer)
- `.ssh/`: SSH configuration
  - `config.d`: Directory for SSH configuration environments in `*.conf` files (Private)
  - `config`: SSH client configuration
- `.chezmoi.yaml.tmpl`: Chezmoi configuration template
- `.lessfilter`: Custom filter for `less` to enhance file preview using `eza`, `bat`, and `exiftool`
- `.zshenv`: Define ZDOTDIR and source `.config/zsh/.zshenv`

## Resources

- [Chezmois Documentation](https://www.chezmoi.io/docs/)
- [Chezmois GitHub Repository](https://github.com/twpayne/chezmoi)
