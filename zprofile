if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

export GOPATH="$HOME/src/go"
export EDITOR="vim"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/local/lib"
export WORKON_HOME="$HOME/virtualenvs"
export PATH="$HOME/local/bin:/usr/local/sbin:$GOPATH/bin:$PATH"
export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

export M3_HOME=/opt/apache-maven
export M2_HOME=$M3_HOME
export M3=$M3_HOME/bin
export M2=$M3

. /usr/local/etc/profile.d/autojump.sh
export GOROOT="/usr/local/opt/go/libexec"
export GROOVY_HOME="${BPFX}/opt/groovy/libexec"
if [ -x "/usr/libexec/java_home" ] ; then
  export JAVA_HOME="$(/usr/libexec/java_home)"
else
  export JAVA_HOME="/usr/lib/jvm/default"
fi

unset SSH_ASKPASS

source /usr/local/bin/virtualenvwrapper.sh
