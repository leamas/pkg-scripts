help_msg = \
Plain 'make' doesn't do anything. Targets: \n\
  - install-home:   Personal user install in ~/man and ~/bin. \n\
  - install-usr:    Install in /usr (as root). \n\
  - dist:           Create dist tarball. \n\
  - uninstall-home,  uninstall-usr: Remove installations\n\
\n\
Variables: \n\
DESTDIR:       For install-usr, relocate installation to DESTDIR/usr

scripts         = fsf-fix rpm-link-sources gitspec git-patchlist
manpages        = $(scripts:=.1)

commit          = $(shell git rev-parse --short HEAD)
tag_version     = $(shell git tag --list --points-at HEAD)
ifeq ($(strip $(tag_version)),)
version = 0
else
version = $(word 1, $(tag_version))
endif


all:
	@echo -e "$(help_msg)"

help:  all

committed: .PHONY
	@if [ -n "$$(git status --short -uno)" ]; then        \
            echo "Warning: there are uncommitted changes.";   \
	fi

install:
	[ -d $(bindir) ] || mkdir -p $(bindir)
	cp $(scripts) $(bindir)
	[ -d $(mandir)/man1 ] || mkdir -p $(mandir)/man1
	cp $(manpages) $(mandir)/man1

uninstall:
	for f in $(scripts); do rm $(bindir)/$$f; done
	for f in $(manpages); do rm $(mandir)/$$f; done

install-home:
	bindir=$(HOME)/bin mandir=$(HOME)/man  $(MAKE) install

install-usr:
	bindir=$(DESTDIR)/usr/bin mandir=$(DESTDIR)/usr/share/man  \
	    $(MAKE) install

uninstall-home:
	bindir=$(HOME)/bin mandir=$(HOME)/man  $(MAKE) uninstall

uninstall-usr:
	bindir=/usr/bin mandir=/usr/share/man  $(MAKE) uninstall

dist: committed
	git archive --prefix=pkg-scripts-$(version)-$(commit)/ \
                    --format=tar.gz HEAD \
	        > pkg-scripts-$(version)-$(commit).tar.gz

.PHONY:
