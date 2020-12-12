//MIT License
//
//Copyright (c) 2019 aneelatwork
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

#include <string>
#include <tuple>
#include <filesystem>
#include <unordered_map>
#include <iostream>

namespace fs = std::filesystem;

fs::path meta_directory( fs::path current_dir, std::string_view const meta_dir )
{
    fs::path git;
    fs::path parent_dir = current_dir.parent_path();

    for( git = current_dir / meta_dir, parent_dir = current_dir.parent_path()
       ; !( fs::is_directory( git ) || parent_dir == current_dir )
       ; current_dir = std::move( parent_dir ), parent_dir = current_dir.parent_path(), git = current_dir / meta_dir );

    if( parent_dir != current_dir ) { return current_dir; }
    throw std::runtime_error( "Current directory is not under a repository" );
}

fs::path base_directory( fs::path current_dir )
{
    fs::path parent_dir = current_dir.parent_path();

    for( parent_dir = current_dir.parent_path()
       ; current_dir.filename() != "src" && current_dir.filename() != "build" && parent_dir != current_dir
       ; current_dir = std::move( parent_dir ), parent_dir = current_dir.parent_path() );

    if( parent_dir != current_dir ) { return  current_dir; }
    throw std::runtime_error( "Current directory is not under src or build directory" );
}

void usage()
{
    std::cerr << "Usage:" << std::endl; 
    std::cerr << "  mk [|r|b]" << std::endl;
    std::cerr << std::endl;
    std::cerr << "Operations:" << std::endl;
    std::cerr << "  : print build directory from source or vice versa." << std::endl;
    std::cerr << " r: print repository parent directory (having .git directory)." << std::endl;
    std::cerr << " b: print work base directory (src/build)." << std::endl;
}

std::string_view const gsrc_base = "src";
std::string_view const gbld_base = "build";
std::string_view const gsrc_meta = ".git";
std::string_view const gbld_meta = "CMakeFiles";

std::tuple< std::string_view, std::string_view, std::string_view > get_context( std::string const& base )
{
    if( base == gsrc_base ) { return std::make_tuple( gsrc_base, gsrc_meta, gbld_base ); }
    if( base == gbld_base ) { return std::make_tuple( gbld_base, gbld_meta, gsrc_base ); }
    throw std::runtime_error( "Couldn't find work base directory" );
}

int main( int argc, char* argv[] )
{
    try
    {
        if( 1 == argc )
        {
            auto const currdir = fs::current_path();
            auto basedir = base_directory( fs::current_path() );
            auto [ base, meta, oppo ] = get_context( basedir.filename().string() );
            auto const relative = fs::relative( meta_directory( currdir, meta ), basedir );
            basedir.remove_filename();
            std::cout << ( basedir / oppo / relative ).string() << std::endl;
            return 0;
        }
        else if( 'r' == argv[ 1 ][ 0 ] ) { std::cout << meta_directory( fs::current_path(), gsrc_meta  ).string() << std::endl; return 0; }
        else if( 'b' == argv[ 1 ][ 0 ] ) { std::cout << base_directory( fs::current_path() ).string() << std::endl; return 0; }
        usage();
    }
    catch( std::exception& ex )
    {
        std::cerr << "Error: " << ex.what() << '.' << std::endl;
    }
    return 1;
}
