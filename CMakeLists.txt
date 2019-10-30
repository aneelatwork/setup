cmake_minimum_required( VERSION 3.1 )
project( setup )

install( CODE "execute_process( COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/dotfiles/vimrc $ENV{HOME}/.vimrc )" )

