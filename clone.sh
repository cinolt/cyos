#!/bin/sh -ev

if [ ! -d "$CYOSROOT/cyos/git/" ]; then
	mkdir "$CYOSROOT/cyos/git/"
	chown cyos:cyos "$CYOSROOT/cyos/git/"
fi

su cyos -c "$CYOSROOT/cyos/clone.cyos.sh"
