#!/bin/bash -eux

# Ensure tmux plugin manager is cloned, it'll take care of the others
[ ! -d plugins ] && mkdir plugins
if [ ! -d plugins/tpm ] ; then
  git clone https://github.com/tmux-plugins/tpm plugins/tpm
fi
git -C plugins/tpm pull --ff-only
