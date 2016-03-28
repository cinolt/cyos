#!/bin/sh -ev

[ "$(id -u)" -ne 0 ]

mkdir -p "$CYOSROOT/home/user/src/"
cd "$CYOSROOT/home/user/src/"
cat "$CYOSROOT/cyos/clone" | while read url; do
	git clone --depth 1 "$url" ||:
done
