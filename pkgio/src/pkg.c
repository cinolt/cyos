#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <errno.h>
#include <dirent.h>
#include "pkg.h"

static char *Name;
static void report( char *P, va_list List ){
	fprintf( stderr, "%s: ", Name );
	vfprintf( stderr, P, List );
	fprintf( stderr, "\n" );
}

void pkg_error( char *P, ... ){
	va_list List;
	va_start( List, P );
	report( P, List );
	va_end( List );

	exit( 1 );
}
static int Status = 0;
void pkg_warn( char *P, ... ){
	va_list List;
	va_start( List, P );
	report( P, List );
	va_end( List );

	Status = 1;
}

char Src[ 4096 ], Dst[ 4096 ];

static void iswhat( void ){
	struct stat Stat;
	if( lstat( Src, &Stat ) ){
		pkg_warn( "lstat %s", Src );
		return;
	}
	if( S_ISDIR( Stat.st_mode ) )
		isdir();
	else
		isother();
}

int main( int ArgC, char **ArgV ){
	Name = ArgV[ 0 ];

	if( ArgC != 3 )
		pkg_error( "usage: %s src dst", Name );

	strcpy( Src, ArgV[ 1 ] );
	strcpy( Dst, ArgV[ 2 ] );
	iswhat();

	return Status;
}

void recurse( void ){
	DIR *Dir = opendir( Src );
	if( !Dir ){
		pkg_warn( "opendir %s", Src );
		return;
	}

	size_t OldSrcLen = strlen( Src );
	size_t OldDstLen = strlen( Dst );

	while( 1 ){
		errno = 0;
		struct dirent *Ent = readdir( Dir );
		if( !Ent ){
			if( errno )
				pkg_warn( "readdir %s", Src );
			break;
		}

		if( !strcmp( Ent->d_name, "." ) )
			continue;
		if( !strcmp( Ent->d_name, ".." ) )
			continue;

		strcat( Src, "/" );
		strcat( Dst, "/" );
		strcat( Src, Ent->d_name );
		strcat( Dst, Ent->d_name );
		iswhat();

		Src[ OldSrcLen ] = 0;
		Dst[ OldDstLen ] = 0;
	}

	if( closedir( Dir ) )
		pkg_warn( "closedir %s", Src );
}
