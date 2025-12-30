#
# ~/.bash_profile
#
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH="/Users/kmaris/Library/Application Support/edgedb/bin:$PATH"
