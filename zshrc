export GPG_TTY=$TTY

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

###### Start timing
#zmodload zsh/datetime
#setopt PROMPT_SUBST
#PS4='+$EPOCHREALTIME %N:%i> '
#
#logfile=$(mktemp zsh_profile.XXXXXXXX)
#echo "Logging to $logfile"
#exec 3>&2 2>$logfile
#
#setopt XTRACE
###### End timing

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

set -o vi
bindkey -v

setopt extendedglob prompt_subst incappendhistory nomatch notify share_history
unsetopt beep auto_cd

fpath+=~/.zfunc
fpath+=~/.docker/completions

autoload -Uz compinit && compinit -i
autoload -Uz colors && colors
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

[ -e "$HOME/.commonrc" ] && source "$HOME/.commonrc"
[ -e "$HOME/.localrc" ] && source "$HOME/.localrc"
#source /usr/share/autojump/autojump.zsh
#source <(/usr/bin/virtualenvwrapper.sh)

# Set up fzf key bindings and fuzzy completion

if type rg &> /dev/null ; then
  export FZF_DEFAULT_COMMAND="rg --files --ignore-file=$HOME/.gitignore"
fi
source <(fzf --zsh)

eval "$(zoxide init zsh)"

# Unstart timinmg
#unsetopt XTRACE
#exec 2>&3 3>&-
