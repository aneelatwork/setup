
echo "${args[ 0 ]}"
set rep_dir "$( bd r )"
if( $rep_dir -eq $null ) { exit 1 }

set bld_dir "$( bd )"
if( $bld_dir -eq $null ) { exit 1 }

if( $args[0] -like "*t*" ) { md -p "$bld_dir" }

pushd "$bld_dir"
if( $args[ 0 ] -like "*c*" ) { cmake "$rep_dir" -DCMAKE_INSTALL_PREFIX="${Env:RAKS_WORK_ROOT}" }
if( $args[ 0 ] -like "*b*" ) { cmake --build . --config Debug }
if( $args[ 0 ] -like "*i*" ) { cmake --install . }
popd
