set -gx HOMEBREW_PREFIX "/opt/homebrew"
set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/homebrew"

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -Ux EDITOR micro
set -Ux VISUAL micro

set fish_greeting

set -Ua fish_user_paths "$HOME/.rye/shims"
set -U fish_user_paths "$HOME/.cargo/bin"
set -gx PATH /opt/homebrew/bin $PATH

uv generate-shell-completion fish | source
function rm; rip --graveyard ~/.Trash $argv; end

bind \e\[122\;9u 'commandline -f undo'
bind \e\[9\;5u 'commandline -f complete-and-search'
set -x MICRO_TRUECOLOR 1
export "MICRO_TRUECOLOR=1"

set -x HOMEBREW_NO_AUTO_UPDATE 1
set -x HOMEBREW_NO_INSTALL_CLEANUP 1
set -x HOMEBREW_NO_ANALYTICS 1
set -x HOMEBREW_NO_COLOR 1
set -x HOMEBREW_CASK_OPTS "--no-quarantine"
set -x HOMEBREW_NO_ENV_HINTS 1

alias update topgrade
alias upgrade topgrade


if test -f (brew --prefix)/etc/brew-wrap.fish
  source (brew --prefix)/etc/brew-wrap.fish
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
zoxide init --cmd cd fish | source
