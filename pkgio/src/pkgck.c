#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include "pkg.h"

void isdir( void ){
	int Ret = mkdir( Dst, 00777 );

	recurse();

	if( !Ret && rmdir( Dst ) )
		pkg_warn( "rmdir %s", Dst );
}

void isother( void ){
	if( link( Src, Dst ) ){
		pkg_warn( "link %s, %s", Src, Dst );
		return;
	}
	if( unlink( Dst ) )
		pkg_warn( "unlink %s", Dst );
}
