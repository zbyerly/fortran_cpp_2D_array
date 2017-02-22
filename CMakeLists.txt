cmake_minimum_required (VERSION 2.6)
project (2darraytest CXX Fortran)

set(CMAKE_VERBOSE_MAKEFILE on)

if (NOT CMAKE_BUILD_TYPE)
  set (CMAKE_BUILD_TYPE DEBUG CACHE STRING
    "Choose the type of build, options are: None Debug Release."
    FORCE)
endif (NOT CMAKE_BUILD_TYPE)

get_filename_component (Fortran_COMPILER_NAME ${CMAKE_Fortran_COMPILER} NAME)

message ("CMAKE_Fortran_COMPILER full path: " ${CMAKE_Fortran_COMPILER})

if (Fortran_COMPILER_NAME MATCHES "gfortran.*")
  message ("Using gfortran...")
  set (CMAKE_Fortran_FLAGS_DEBUG "-g -O0 -cpp -Wall -fbacktrace")
elseif (Fortran_COMPILER_NAMES MATCHES "ifort.*")
  message ("Using ifort...")
  set (CMAKE_Fortran_FLAGS_DEBUG "-O0 -g")
  set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -lifcoremt")

endif (Fortran_COMPILER_NAME MATCHES "gfortran.*")

add_executable(
  2Darraytest
  2D_array.cpp
  fname.h
  fortran_function.F90
  fortran_module.F90
  )

target_link_libraries(2Darraytest gfortran)
