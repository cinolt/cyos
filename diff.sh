#!/bin/sh -ev

cd "$CYOSROOT/home/user/src/"
for repo in *; do
	cd "$CYOSROOT/home/user/src/$repo/.git/refs/heads/"
	for branch in *; do
		[ "$branch" != master ] || continue
		cd "$CYOSROOT/home/user/src/$repo/"
		git checkout "$bcanch"
		mkdir -p "$CYOSROOT/cyos/diff/$repo"
		git diff master > "$CYOSROOT/cyos/diff/$repo/$branch"
	done
done
