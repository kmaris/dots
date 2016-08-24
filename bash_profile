#
# ~/.bash_profile
#
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
