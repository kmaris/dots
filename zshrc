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

source /opt/homebrew/Cellar/powerlevel10k/1.20.0/share/powerlevel10k/powerlevel10k.zsh-theme

# Unstart timinmg
#unsetopt XTRACE
#exec 2>&3 3>&-
source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
