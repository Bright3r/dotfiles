# Prompt (Starship)
starship init fish | source
if test -f ~/.config/fish/themes/colors.fish
    cat ~/.config/fish/themes/colors.fish
end

# Greeting
set fish_greeting "Welcome to fish"\n(date "+%c")

# SSH
if status is-interactive
	keychain --quiet --agents ssh id_ed25519 2>/dev/null
end

# PATH VARIABLES
set -x TERMINAL foot

# VCPKG
set -x VCPKG_ROOT $HOME/.local/share/vcpkg
set -x PATH $VCPKG_ROOT $PATH

# ALIASES
alias pamcan=pacman
alias vim="nvim"

# BINDS
bind \cd delete-char
