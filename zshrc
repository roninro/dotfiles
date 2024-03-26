# HISTORY
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY             # Share history between all sessions.
# # END HISTORY

# OrbStack
[[ -d "/Applications/OrbStack.app/Contents/Resources/completions/zsh" ]] && FPATH="/Applications/OrbStack.app/Contents/Resources/completions/zsh:${FPATH}"

# Zap
local ZAP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zap"
local BRANCH=release-v1
if [ ! -d "${ZAP_DIR}" ]; then
    git clone -b "$BRANCH[-1]" https://github.com/zap-zsh/zap.git "$ZAP_DIR" &> /dev/null || { echo "❌ Git is a dependency for zap. Please install git and try again." && return 2 }
fi

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "zap-zsh/zap-prompt"
plug "wintermi/zsh-brew"
plug "zap-zsh/fzf"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"
plug "zsh-users/zsh-completions"
{{#if (is_executable "starship")}}
plug "wintermi/zsh-starship"
{{/if}}
plug "djui/alias-tips"

# Load and initialise completion system
autoload -Uz compinit
compinit

#==> Aliases
# ls
{{#if (is_executable "eza")}}
# alias l="eza --time-style long-iso --color=auto -F"
# alias ll="l -ahl"
alias ls='eza --group-directories-first --icons auto'
alias ll='ls -lh --git'
alias la='ll -a'
alias tree='eza --tree --level=2'

{{else}}
alias l="ls --color=auto -F"
alias ll="l -Ahl"
{{/if}}

# Clearing screen
alias c="echo -ne '\033c';"
alias cl="c l"
alias cll="c ll"

# Interactive commands
alias mv="mv -i"  # "m" - never forget
alias cp="cp -i"

# Move up quickly
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .5="cd ../../../.."
alias .6="cd ../../../../.."
alias .7="cd ../../../../../.."
alias .8="cd ../../../../../../.."

# Git
alias ga="git add"
alias gb="git branch"
alias gca="git commit -a"
alias gcam="git commit -am"
alias gc="git commit"
alias gcm="git commit -m"
alias gd="git diff"
alias gds="git diff --staged"
alias glg="git log --all --oneline --graph --decorate"
alias gpl="git pull --prune"
alias gps="git push"
alias gm="git merge"
alias gs="git status -sb"
alias gs-="git switch -"

{{#if (is_executable "bat")}}
alias cat="bat"
{{/if}}
{{#if (is_executable "fzf")}}
j ()  # Navigate with fzf
{
    {{#if (is_executable "fd")}}
    find_command='fd . ~ --type d'
    {{else}}
    # Settle for not hiding gitignored stuff
    find_command='find ~ -type d'
    {{/if}}
    dir=$(eval $find_command | fzf --preview 'tree -CF -L 2 {+1}')
    fzf_return=$?
    [ $fzf_return = 0 ] && cd $dir || return $fzf_return
}
{{/if}}

# Kitty ssh fix
alias ssh="TERM=xterm-256color ssh"

# Local zshrc
[ -f ~/.zshrc.local ] && . ~/.zshrc.local
