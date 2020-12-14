#MIT License
#
#Copyright (c) 2019 aneelatwork
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.

echo "${args[ 0 ]}"
set rep_dir "$( bd r )"
if( $rep_dir -eq $null ) { exit 1 }

set bld_dir "$( bd )"
if( $bld_dir -eq $null ) { exit 1 }

if( $args[0] -like "*t*" ) { md -p "$bld_dir" }

pushd "$bld_dir"

if( $args[ 0 ] -like "*p*" ) { conan install "$rep_dir" }

if( $args[ 0 ] -like "*[p|c]*" )
{
    cmake "$rep_dir" -G "Ninja" -DCMAKE_INSTALL_PREFIX="${Env:RAKS_WORK_ROOT}" -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Debug
}

if( $args[ 0 ] -like "*b*" )
{
    cmake --build . --config Debug
    cp compile_commands.json "$rep_dir/"
}

if( $args[ 0 ] -like "*i*" ) { cmake --install . }
popd
