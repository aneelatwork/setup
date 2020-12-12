cmake_minimum_required( VERSION 3.19 )
project( "bd" )

set( CMAKE_CXX_STANDARD 20 )

set( CMAKE_BUILD_TYPE Release CACHE STRING "either None Debug Release RelWithDebInfo MinSizeRel" FORCE )

add_executable( ${CMAKE_PROJECT_NAME} bd.cpp )

install( TARGETS ${CMAKE_PROJECT_NAME} RUNTIME DESTINATION bin COMPONENT RUNTIME )

if( UNIX )
    install( PROGRAMS mk DESTINATION bin )
endif( UNIX )

if( WIN32 )
    install( PROGRAMS mk.ps1 DESTINATION bin )
endif( WIN32 )

