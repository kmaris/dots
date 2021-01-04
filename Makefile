################
#
# Makefile to install dotfiles and run their init scripts.
#
################
SHELL := /bin/bash

FIND_EXCLUDES := \! \( -name Makefile -or -name README.md -or -name .\* -or -name \*.init \)
DOTS := $(addprefix $(HOME)/., $(notdir $(shell find . -mindepth 1 -maxdepth 1 $(FIND_EXCLUDES))))
INITS := $(shell find . -mindepth 2 -maxdepth 2 -name init.sh)

.PHONY: all init install-hook
all: $(DOTS) $(INITS)

$(INITS): 
	@for init_file in $$(ls *.init) ; do pushd $$(dirname $$init_file); sh $$init_file ; popd ; done
	@find . -name init.sh -execdir sh {} \;

install-hook:
	echo -e "#!/bin/bash\nmake"  > .git/hooks/post-merge
	chmod +x .git/hooks/post-merge

%/init.dot:
	cd $$(dirname "$@")
	echo $@

$(HOME)/.%: %
	@if [ -f "$@" ] || [ -d "$@" ] ; then \
	  echo "Backing up $@ to $@.old" ; \
	  mv "$@" "$@.old" ; \
	elif [ -h "$@" ] ; then \
	  rm "$@" ; \
	fi
	ln -sf $(CURDIR)/$< $@
	@if [ -x "$<.init" ] ; then \
	  sh "$<.init" ; \
	elif [ -x "$</init.dot" ] ; then \
	  pushd $< ; \
	  sh "$</init.dot" ; \
	  popd ; \
	fi
