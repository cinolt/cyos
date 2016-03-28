#!/bin/sh -ev

[ "$(id -u)" -ne 0 ]

cd "$CYOSROOT/home/user/src/"
for repo in *; do
	cd "$CYOSROOT/home/user/src/$repo/"
	git checkout master
	if [ "$(git remote)" ]; then
		git fetch --depth 1
		git reset --hard origin/master
	fi
	[ -e "$CYOSROOT/cyos/diff/$repo" ] || continue
	cd "$CYOSROOT/cyos/diff/$repo/"
	for branch in *; do
		cd "$CYOSROOT/home/user/src/$repo/"
		[ ! -e ".git/refs/heads/$branch" ] || git branch -D "$branch"
		git checkout -b "$branch"
		git apply --index "$CYOSROOT/cyos/diff/$repo/$branch"
		git commit -m cyos
	done
done
