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

autoload -Uz compinit
compinit -C
autoload -Uz colors && colors
autoload -Uz vcs_info

# For source controls prompt info
zstyle ':compinstall' filename $HOME/.zshrc
zstyle ':vcs_info:*' enable svn git
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]):*' branchformat '%b%F{1}:%F{3}%r'

# Use precmd to do vcs_info, notifications, etc.
precmd() {
  vcs_info
}

if [[ $UID -eq 0 ]]; then # root
    eval PR_USER='%{$fg[red]%}%n@%m'
else
    eval PR_USER='%{$fg[green]%}%n@%m'
fi
PS1='$PR_USER %{$fg[yellow]%}%~%{$reset_color%} ${vcs_info_msg_0_}> '

[ -e "$HOME/.commonrc" ] && source "$HOME/.commonrc"
[ -e "$HOME/.localrc" ] && source "$HOME/.localrc"

# Unstart timinmg
#unsetopt XTRACE
#exec 2>&3 3>&-
