if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

export GOPATH="$HOME/src/go"
export EDITOR="vim"
#export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/local/lib"
export WORKON_HOME="$HOME/virtualenvs"
export PATH="$HOME/local/bin:/usr/local/sbin:$GOPATH/bin:$PATH"
export PATH="$HOME/.asdf/shims:$PATH"
export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

. /usr/local/etc/autojump.sh
export JAVA_HOME="/usr/local/opt/openjdk"

unset SSH_ASKPASS
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s` 2>1 >/dev/null
fi

export PATH="/Users/kmaris/Library/Application Support/edgedb/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
