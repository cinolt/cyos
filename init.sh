#!/bin/sh -ev

cd "$CYOS/home/user/pkgsh"

a(){
	pkg="$1"
	[ -z "$CYOS" ] || pkg="old-$1"

	./pkg.sh "$1" "$pkg"
}

b(){
	pkg="$1"
	[ -z "$CYOS" ] || pkg="old-$1"

	mv "$CYOS/home/user/pkg/$pkg"{,-tmp}
	./pkg.sh "$1" "$pkg" "$pkg-tmp"
}

c(){
	if [ "$CYOS" ]; then
		./pkg.sh "$1" "old-$1"
		mv "$CYOS/home/user/pkg/old-$1"{,-tmp}
		mv "$CYOS/home/user/pkg/old-$1"{-tmp/myos,}
		rm -R "$CYOS/home/user/pkg/old-$1-tmp"
	else
		./pkg.sh "$1" "$1" "old-$1"
	fi
}

export CYOS_PATH=
a linux-hdr
a glibc
a glibc-32
a binutils
a gcc
CYOS_PATH="$CYOS/usr/bin"
a zlib
a gmp
a mpfr
a mpc
b binutils
b gcc
a db
a gdbm
a pcre
a ncurses
a readline
a pam
a gzip
a bzip2
a xz
a tar
a pkgio
a util-linux
a coreutils
a diffutils
a findutils
a inetutils
a file
a grep
a sed
a gawk
a make
a m4
a perl
a autoconf
a automake
a libtool
a gettext
a kbd
c sysvinit
c bash
c dash
