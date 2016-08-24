[ -f /etc/bashrc ] && source /etc/bashrc

for f in /etc/bash_completion.d/*; do
  source "$f" 2>/dev/null
done

set -o vi

[ -e "$HOME/.commonrc" ] && source "$HOME/.commonrc"
[ -e "$HOME/.localrc" ] && source "$HOME/.localrc"

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend # append to the history file, don't overwrite it

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# By default do color prompts if available.
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='\u@\h:\w\$ '
fi
