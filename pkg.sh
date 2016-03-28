#!/bin/sh -ev

name="$1"
pkg="$2"
out="$3"

[ "$name" ]
[ "$pkg" ] || pkg="$name"
[ ! -e "$CYOS/home/user/cyos/pkg/$pkg" ]
[ -z "$out" ] || [ -e "$CYOS/home/user/cyos/pkg/$out" ]

"$CYOS/home/user/cyos/su.sh" "CYOS=\"$CYOS\" PATH=\"$CYOS_PATH:\$PATH\" \"$CYOS/home/user/cyos/pkgsh/$name.sh\" \"$pkg\""
"$CYOS/home/user/cyos/pkgsh/$name.sh" "$pkg"

cd "$CYOS/home/user/cyos/pkg"
if [ "$out" ]; then
	pkgout "$out" "/$CYOS"
fi
pkgck "$pkg" "/$CYOS"
pkgin "$pkg" "/$CYOS"
