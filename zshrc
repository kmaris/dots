[ -e "$HOME/.commonrc" ] && source "$HOME/.commonrc"
[ -e "$HOME/.localrc" ] && source "$HOME/.localrc"

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

set -o vi
bindkey -v

setopt extendedglob
setopt completealiases
setopt prompt_subst
unsetopt beep

autoload -Uz compinit && compinit
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