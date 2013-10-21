## pkg-scripts README

Some scripts I use when packaging Fedora apps.
- fsf-fix: Patch bad addresses to Free Software Foundation causing rpmlint
  warnings.
- rpm-link-sources: shorthand for linking source files to rpmbuild's
  SOURCE directory.
- gitspec: Reuse git commit messages as spec file changelog.
- git-patchlist: Create spec patchlist from list of git patches.

## Status
This is in the dogfood status: I'm using this for my own needs.  Let's call
it sort of alpha.

## Download
Either use git:
```
    $ git clone  https://github.com/leamas/pkg-scripts
    $ cd pkg-scripts
```
or download a tarball and use that:
```
    $ wget https://github.com/leamas/etc-cleaner/tarball/master/pkg-scripts.tar.gz
    $ tar xzf pkg-scripts.tar.gz
    $ cd leamas-pkg-scripts-*
```

## Setup

Scripts can be run directly from the git source dir. Two installation
modes are supported using the Makefile:
```
$ make help
Plain 'make' doesn't do anything. Targets:
 - install-home:   Personal user install in ~/man and ~/bin.
 - install-usr:    Install in /usr (as root).
 - dist:           Create dist tarball.
 - uninstall-home, uninstall-usr: Remove installations.

 Variables:
 DESTDIR: For install-usr, relocate installation to DESTDIR/usr.
```

## License

These files are in public domain, do whatever you want with them.
