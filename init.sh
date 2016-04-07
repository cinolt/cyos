#!/bin/sh -ev

[ "$1" ]
[ -d "$1" ]
case "$1" in
	*/*) false ;;
	*-*) true ;;
	*) false ;;
esac

name="${1%-*}"
ver="${1##*-}"
[ "$name" ]
[ "$ver" ]

export GIT_DIR="$CYOSROOT/cyos/git/$name.git/"
export GIT_WORK_TREE="$CYOSROOT/cyos/work/$1/"
mkdir "$GIT_DIR"

git init
git add .
git commit -m "ver $ver"
