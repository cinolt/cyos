#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include "pkg.h"

void isdir( void ){
	mkdir( Dst, 00777 );
	recurse();
}

void isother( void ){
	if( link( Src, Dst ) )
		pkg_warn( "link %s, %s", Src, Dst );
}
