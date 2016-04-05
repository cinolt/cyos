#!/bin/sh -ev

if [ "$CYOSROOT" ]; then
	cd "$CYOSROOT"

	mkdir dev proc sys root

	mkdir home home/user
	chown user:users home/user

	mkdir usr
	for X in bin sbin lib lib32 etc var; do
		mkdir "usr/$X"
		ln -s "$CYOSROOT/usr/$X" .
	done
	ln -s lib usr/lib64
	ln -s "$CYOSROOT/usr/lib64" .

	mkdir var/log var/tmp var/run
	ln -s var/tmp .
	ln -s var/run .
	chmod 1777 var/tmp
else
	cd /
	echo hi
fi
