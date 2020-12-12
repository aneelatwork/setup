
set rep_dir "$( bd r )" || exit 1
set bld_dir "$( bd )" || exit 1

if( $arg[0] -like "*t*" ) { md -p "$bld_dir" }
(
cd "$bld_dir"
if( $arg[ 0 ] -like "*c*" ) { cmake "$rep_dir" -DCMAKE_INSTALL_PREFIX="${Env:RAKS_WORK_ROOT}" }
if( $arg[ 0 ] -like "*b*" ) { cmake --build . --config Debug }
if( $arg[ 0 ] -like "*i*" ) { cmake --install . }
)

