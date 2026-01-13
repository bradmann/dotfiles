# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files sourced from it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

# ==============================================================================
# z4h Pre-Init Configuration (must be before z4h init)
# ==============================================================================

# Periodic auto-update on Zsh startup: 'ask' or 'no'.
# You can manually run `z4h update` to update everything.
zstyle ':z4h:' auto-update      'yes'
# Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:' auto-update-days '28'

# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey' keyboard  'mac'

# Start tmux if not already in tmux.
zstyle ':z4h:' start-tmux command tmux -u new -A -D -t z4h$(tty)

# Whether to move prompt to the bottom when zsh starts and on Ctrl+L.
zstyle ':z4h:' prompt-at-bottom 'yes'

# Mark up shell's output with semantic information.
zstyle ':z4h:' term-shell-integration 'yes'

zstyle ':z4h:' propagate-cwd yes

# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char 'accept'

# Recursively traverse directories when TAB-completing files.
zstyle ':z4h:fzf-complete' recurse-dirs 'no'

# https://github.com/romkatv/zsh4humans/blob/master/tips.md#completions
zstyle ':z4h:fzf-complete' fzf-bindings tab:repeat

# https://github.com/romkatv/zsh4humans/blob/master/tips.md#fzf
zstyle ':z4h:*' fzf-flags --color=hl:31,hl+:31

# Enable direnv to automatically source .envrc files.
zstyle ':z4h:direnv'         enable 'no'
# Show "loading" and "unloading" notifications from direnv.
zstyle ':z4h:direnv:success' notify 'yes'

# Enable ('yes') or disable ('no') automatic teleportation of z4h over
# SSH when connecting to these hosts.
zstyle ':z4h:ssh:example-hostname1'   enable 'yes'
zstyle ':z4h:ssh:*.example-hostname2' enable 'no'
# The default value if none of the overrides above match the hostname.
zstyle ':z4h:ssh:*'                   enable 'yes'

# Send these files over to the remote host when connecting over SSH to the
# enabled hosts.
zstyle ':z4h:ssh:*' send-extra-files '~/.nanorc' '~/.env.zsh' '~/.p10k.zsh' '~/.p10k.zsh.pwc' '~/.tmux.conf' '~/.vimrc' '~/.zshrc.d'

# Improve the terminal title when connecting over SSH.
zstyle ':z4h:term-title:ssh' preexec '%n@'${${${Z4H_SSH##*:}//\%/%%}:-%m}': ${1//\%/%%}'
zstyle ':z4h:term-title:ssh' precmd  '%n@'${${${Z4H_SSH##*:}//\%/%%}:-%m}': %~'

# ==============================================================================
# z4h Initialization
# ==============================================================================

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# ==============================================================================
# Function Loading
# ==============================================================================

# Autoload standard functions
autoload -Uz zmv

# Set up fpath for custom functions and completions
fpath=(~/.zsh/functions $fpath)

# Autoload all custom functions
autoload -Uz ~/.zsh/functions/[^_]*(:t)

# Initialize the completion system (scans fpath for #compdef tags)
autoload -Uz compinit && compinit

# ==============================================================================
# Environment Configuration
# ==============================================================================

# Export environment variables
export GPG_TTY=$TTY

# Source additional local files if they exist
z4h source ~/.env.zsh

# Source modular configuration files from .zshrc.d/
# Files starting with . are sourced (e.g., .aliases, .path, .databricksrc)
z4h source ~/.zshrc.d/.[^_]*

# ==============================================================================
# Named Directories
# ==============================================================================

# Define named directories: ~w <=> Windows home directory on WSL
[[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

# ==============================================================================
# Machine-Specific Configuration
# ==============================================================================

# Source machine-specific overrides (not tracked by yadm)
z4h source ~/.zshrc.local
