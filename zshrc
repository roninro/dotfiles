# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


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

XDG_CACHE_HOME=$HOME/.cache
ZSH_CUSTOM_PLUGINS=$XDG_CACHE_HOME/zsh/plugins
ZSH_CUSTOM_COMPLETIONS=$XDG_CACHE_HOME/zsh/completions
alias src='source'
if [ -d $ZSH_CUSTOM_PLUGINS/zsh-defer ]; then
  alias src='zsh-defer source'
  source $ZSH_CUSTOM_PLUGINS/zsh-defer/zsh-defer.plugin.zsh
fi


if [ -d $ZSH_CUSTOM_PLUGINS/fast-syntax-highlighting ]; then
  src $ZSH_CUSTOM_PLUGINS/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fi

if [ -d $ZSH_CUSTOM_PLUGINS/powerlevel10k ]; then
  source $ZSH_CUSTOM_PLUGINS/powerlevel10k/powerlevel10k.zsh-theme
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
