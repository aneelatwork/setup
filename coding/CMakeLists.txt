cmake_minimum_required(VERSION 4.0.3)

set(CMAKE_EXPERIMENTAL_CXX_IMPORT_STD "d0edc3af-4c50-42ea-a356-e2862fe7a444")
set(CMAKE_CXX_MODULE_STD ON)

project(bcd VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_BUILD_TYPE Debug CACHE STRING "either None Debug Release RelWithDebInfo MinSizeRel" FORCE)

if (MSVC)
    add_compile_options("/EHsc")
endif (MSVC)

#add_library(${CMAKE_PROJECT_NAME})
add_executable(${CMAKE_PROJECT_NAME})

target_sources(${CMAKE_PROJECT_NAME}
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src/bcd.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/main.cpp

#    PUBLIC FILE_SET public_module TYPE CXX_MODULES
    PUBLIC
        FILE_SET CXX_MODULES
        FILES
            ${CMAKE_CURRENT_SOURCE_DIR}/include/raks/code/bcd.cppm
)

#enable_testing()
#add_subdirectory(test)
