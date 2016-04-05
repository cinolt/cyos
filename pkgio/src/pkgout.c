#include <unistd.h>
#include "pkg.h"

void isdir( void ){
	recurse();
	rmdir( Dst );
}

void isother( void ){
	if( unlink( Dst ) )
		pkg_warn( "unlink %s", Dst );
}
