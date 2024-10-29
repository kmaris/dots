#
# ~/.bash_profile
#
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH="/Users/kmaris/Library/Application Support/edgedb/bin:$PATH"
