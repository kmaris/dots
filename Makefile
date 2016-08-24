################
#
# Makefile to install dotfiles. Files ending in .dot will be copied to $HOME
# as $HOME/.<filename> sans the .dot extension.
#
################
SHELL = /bin/bash

DOTS = $(addprefix $(HOME)/., $(filter-out Makefile %.init, $(wildcard *)))

.PHONY: all
all: $(DOTS)

.PHONY: init
init:
	@for init_file in $$(ls *.init) ; do \
	  echo "=== $$init_file ===" ; \
	  sh $$init_file ; \
	done

$(HOME)/.%: %
	@if [ -f "$@" ] || [ -d "$@" ] ; then \
	  echo "Backing up $@ to $@.old" ; \
	  mv "$@" "$@.old" ; \
	elif [ -h "$@" ] ; then \
	  rm "$@" ; \
	fi
	ln -s $(CURDIR)/$< $@
	@[ -x "$(*F).init" ] && sh "$(*F).init" || true
