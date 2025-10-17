# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files sourced from it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

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

# Clone additional Git repositories from GitHub.
#
# This doesn't do anything apart from cloning the repository and keeping it
# up-to-date. Cloned files can be used after `z4h init`. This is just an
# example. If you don't plan to use Oh My Zsh, delete this line.
# z4h install ohmyzsh/ohmyzsh || return

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# Extend PATH.
export PATH="$HOME/bin:$HOME/go/bin:$HOME/.cargo/bin:$HOME/.pyenv/bin:$PATH"

# Export environment variables.
export GPG_TTY=$TTY

# Source additional local files if they exist.
z4h source ~/.env.zsh

# Source additional local files if they exist.
z4h source ~/.zshrc.d/.[^_]*

# Use additional Git repositories pulled in with `z4h install`.
#
# This is just an example that you should delete. It does nothing useful.
# z4h source ohmyzsh/ohmyzsh/lib/diagnostics.zsh  # source an individual file
# z4h load   ohmyzsh/ohmyzsh/plugins/emoji-clock  # load a plugin

# Define key bindings.
z4h bindkey undo Ctrl+/   Shift+Tab  # undo the last command line change
z4h bindkey redo Option+/            # redo the last undone command line change

z4h bindkey z4h-cd-back    Shift+Left   # cd into the previous directory
z4h bindkey z4h-cd-forward Shift+Right  # cd into the next directory
z4h bindkey z4h-cd-up      Shift+Up     # cd into the parent directory
z4h bindkey z4h-cd-down    Shift+Down   # cd into a child directory

# https://github.com/romkatv/zsh4humans/blob/master/tips.md#prompt
z4h bindkey z4h-eof Ctrl+D
setopt ignore_eof
POSTEDIT=$'\n\e[A'
z4h bindkey z4h-accept-line Enter


# Autoload functions.
autoload -Uz zmv

# Define functions and completions.
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md

# Define named directories: ~w <=> Windows home directory on WSL.
[[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

# Alias ls to lsd if it is available
if hash lsd 2>/dev/null; then
  alias ls=lsd
fi

# Add flags to existing aliases.
alias ls="${aliases[ls]:-ls} -A"
alias ll="${aliases[ll]:-ls} -lA"
alias la="${aliases[la]:-ls} -a"
alias clear=z4h-clear-screen-soft-bottom

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu

# Show motd.dynamic if it exists.
[ -e "/run/motd.dynamic" ] && cat /run/motd.dynamic

# fnm
FNM_PATH="/Users/brad.mann/Library/Application Support/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/Users/brad.mann/Library/Application Support/fnm:$PATH"
  eval "`fnm env`"
fi

FNM_PATH="/home/bradm/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/bradm/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi
