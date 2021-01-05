#if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

export GOPATH="$HOME/src/go"
export EDITOR="gvim -v"
export VISUAL="$EDITOR"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/local/lib"
export WORKON_HOME="$HOME/virtualenvs"
export PATH="$HOME/local/bin:/usr/local/sbin:$GOPATH/bin:$PATH"
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

. /usr/share/autojump/autojump.zsh
export JAVA_HOME="/usr/lib/jvm/default-java"

unset SSH_ASKPASS
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s` >/dev/null
fi
#source <(/usr/local/bin/pyenv-sh-virtualenvwrapper)
