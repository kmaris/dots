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
HISTSIZE=1000
SAVEHIST=1000

set -o vi
bindkey -v

setopt extendedglob completealiases prompt_subst appendhistory auto_cd nomatch notify
unsetopt beep

fpath+=~/.zfunc

autoload -Uz compinit && compinit -i
autoload -Uz colors && colors

[ -e "$HOME/.commonrc" ] && source "$HOME/.commonrc"
[ -e "$HOME/.localrc" ] && source "$HOME/.localrc"

# Unstart timinmg
#unsetopt XTRACE
#exec 2>&3 3>&-
source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
