################
#
# Makefile to install dotfiles and run their init scripts.
#
################
SHELL := /bin/bash

FIND_EXCLUDES := \! \( -name Makefile -or -name README.md -or -name .\* -or -name \*.init \)
DOTS := $(addprefix $(HOME)/., $(notdir $(shell find . -mindepth 1 -maxdepth 1 $(FIND_EXCLUDES))))

.PHONY: all init install-hook
all: $(DOTS)

init:
	@for init_file in $$(ls *.init) ; do \
	  echo "=== $$init_file ===" ; \
	  sh $$init_file ; \
	done

install-hook:
	echo -e "#!/bin/bash\nmake all"  > .git/hooks/post-merge
	chmod +x .git/hooks/post-merge

$(HOME)/.%: %
	@if [ -f "$@" ] || [ -d "$@" ] ; then \
	  echo "Backing up $@ to $@.old" ; \
	  mv "$@" "$@.old" ; \
	elif [ -h "$@" ] ; then \
	  rm "$@" ; \
	fi
	ln -s $(CURDIR)/$< $@
	@[ -x "$(*F).init" ] && sh "$(*F).init" || true
