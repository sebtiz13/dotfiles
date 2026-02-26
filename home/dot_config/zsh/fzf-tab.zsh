# Define custom sources for fzf-tab scripts
# Look customize: https://github.com/Freed-Wu/fzf-tab-source?tab=readme-ov-file#customize
zstyle ':fzf-tab:sources' config-directory $XDG_CONFIG_HOME/zsh/sources

# ? FZF-tab configurations
# Use fzf default options for fzf-tab
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# Use space to accept
zstyle ':fzf-tab:*' fzf-bindings 'space:accept'
# Toggle preview window
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-/:toggle-preview'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
# Define min height for fzf-tab result to improve preview
zstyle ':fzf-tab:*' fzf-min-height '20'
