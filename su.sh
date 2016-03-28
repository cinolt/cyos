#!/bin/sh -ev
[ "$CYOS_USER" ] || CYOS_USER=user

[ "$1" ]

opt=--session-command
[ -z "$MYOS" ] || opt=-c # ASSUME: shadow su
opt=-c # REMOVE ME
su "$CYOS_USER" "$opt" "$1"
