#!/bin/bash -eux

# Ensure tmux plugin manager is cloned, it'll take care of the others
mkdir plugins
git clone https://github.com/tmux-plugins/tpm plugins/tpm
