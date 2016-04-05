#pragma once

extern void pkg_error( char *P, ... );
extern void pkg_warn( char *P, ... );
extern char Src[], Dst[];
extern void recurse( void );

extern void isdir( void );
extern void isother( void );
