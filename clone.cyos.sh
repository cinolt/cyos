#!/bin/sh -ev

while read url; do
	repo="${url##*/}"
	name="${repo%.git}"

	[ ! -d "$CYOSROOT/cyos/git/$repo/" ] || continue
	git clone --bare --depth 1 "$url" "$CYOSROOT/cyos/git/$repo/"

	[ -d "$CYOSROOT/cyos/diff/$name/" ] || continue
	cd "$CYOSROOT/cyos/diff/$name/"
	for branch in *; do
		echo "$branch"
	done
done
