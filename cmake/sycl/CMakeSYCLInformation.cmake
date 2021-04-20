# VecMem project, part of the ACTS project (R&D line)
#
# (c) 2021 CERN for the benefit of the ACTS project
#
# Mozilla Public License Version 2.0

# Set up how SYCL object file compilation should go.
set( CMAKE_SYCL_COMPILE_OBJECT
   "<CMAKE_SYCL_COMPILER> -fsycl -fsycl-targets=${CMAKE_SYCL_TARGETS} -x c++ <DEFINES> <INCLUDES> <FLAGS> -o <OBJECT> -c <SOURCE>" )

# Set up how shared library building should go.
if( NOT DEFINED CMAKE_SHARED_LIBRARY_CREATE_SYCL_FLAGS )
   set( CMAKE_SHARED_LIBRARY_CREATE_SYCL_FLAGS
      "${CMAKE_SHARED_LIBRARY_CREATE_CXX_FLAGS}" )
endif()
if( NOT DEFINED CMAKE_SHARED_LIBRARY_SYCL_FLAGS )
   set( CMAKE_SHARED_LIBRARY_SYCL_FLAGS
      "${CMAKE_SHARED_LIBRARY_CXX_FLAGS} -fsycl -fsycl-targets=${CMAKE_SYCL_TARGETS}" )
endif()
if( NOT DEFINED CMAKE_SHARED_LIBRARY_LINK_SYCL_FLAGS )
   set( CMAKE_SHARED_LIBRARY_LINK_SYCL_FLAGS
      "${CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS}" )
endif()
if( NOT DEFINED CMAKE_SHARED_LIBRARY_RUNTIME_SYCL_FLAG )
   set( CMAKE_SHARED_LIBRARY_RUNTIME_SYCL_FLAG
      "${CMAKE_SHARED_LIBRARY_RUNTIME_CXX_FLAG}" )
endif()
if( NOT DEFINED CMAKE_SHARED_LIBRARY_RUNTIME_SYCL_FLAG_SEP )
   set( CMAKE_SHARED_LIBRARY_RUNTIME_SYCL_FLAG_SEP
      "${CMAKE_SHARED_LIBRARY_RUNTIME_CXX_FLAG_SEP}" )
endif()
if( NOT DEFINED CMAKE_SHARED_LIBRARY_RPATH_LINK_SYCL_FLAG )
   set( CMAKE_SHARED_LIBRARY_RPATH_LINK_SYCL_FLAG
      "${CMAKE_SHARED_LIBRARY_RPATH_LINK_CXX_FLAG}" )
endif()
if( NOT DEFINED CMAKE_SHARED_LIBRARY_EXPORTS_SYCL_FLAG )
   set( CMAKE_SHARED_LIBRARY_EXPORTS_SYCL_FLAG
      "${CMAKE_SHARED_LIBRARY_EXPORTS_CXX_FLAG}" )
endif()
if( NOT DEFINED CMAKE_SHARED_LIBRARY_SONAME_SYCL_FLAG )
   set( CMAKE_SHARED_LIBRARY_SONAME_SYCL_FLAG
      "${CMAKE_SHARED_LIBRARY_SONAME_CXX_FLAG}" )
endif()
set( CMAKE_SYCL_CREATE_SHARED_LIBRARY
   "${CMAKE_SYCL_HOST_LINKER} <CMAKE_SHARED_LIBRARY_SYCL_FLAGS> <LANGUAGE_COMPILE_FLAGS> <LINK_FLAGS> <CMAKE_SHARED_LIBRARY_CREATE_SYCL_FLAGS> <SONAME_FLAG><TARGET_SONAME> -o <TARGET> <OBJECTS> <LINK_LIBRARIES>" )

# Set up how module library building should go.
if( NOT DEFINED CMAKE_SHARED_MODULE_CREATE_SYCL_FLAGS )
   set( CMAKE_SHARED_MODULE_CREATE_SYCL_FLAGS
      "${CMAKE_SHARED_MODULE_CREATE_CXX_FLAGS}" )
endif()
if( NOT DEFINED CMAKE_SHARED_MODULE_SYCL_FLAGS )
   set( CMAKE_SHARED_MODULE_SYCL_FLAGS
      "${CMAKE_SHARED_MODULE_CXX_FLAGS} -fsycl -fsycl-targets=${CMAKE_SYCL_TARGETS}" )
endif()
if( NOT DEFINED CMAKE_SHARED_MODULE_LINK_SYCL_FLAGS )
   set( CMAKE_SHARED_MODULE_LINK_SYCL_FLAGS
      "${CMAKE_SHARED_MODULE_LINK_CXX_FLAGS}" )
endif()
if( NOT DEFINED CMAKE_SHARED_MODULE_RUNTIME_SYCL_FLAG )
   set( CMAKE_SHARED_MODULE_RUNTIME_SYCL_FLAG
      "${CMAKE_SHARED_MODULE_RUNTIME_CXX_FLAG}" )
endif()
if( NOT DEFINED CMAKE_SHARED_MODULE_RUNTIME_SYCL_FLAG_SEP )
   set( CMAKE_SHARED_MODULE_RUNTIME_SYCL_FLAG_SEP
      "${CMAKE_SHARED_MODULE_RUNTIME_CXX_FLAG_SEP}" )
endif()
if( NOT DEFINED CMAKE_SHARED_MODULE_RPATH_LINK_SYCL_FLAG )
   set( CMAKE_SHARED_MODULE_RPATH_LINK_SYCL_FLAG
      "${CMAKE_SHARED_MODULE_RPATH_LINK_CXX_FLAG}" )
endif()
if( NOT DEFINED CMAKE_SHARED_MODULE_EXPORTS_SYCL_FLAG )
   set( CMAKE_SHARED_MODULE_EXPORTS_SYCL_FLAG
      "${CMAKE_SHARED_MODULE_EXPORTS_CXX_FLAG}" )
endif()
if( NOT DEFINED CMAKE_SHARED_MODULE_SONAME_SYCL_FLAG )
   set( CMAKE_SHARED_MODULE_SONAME_SYCL_FLAG
      "${CMAKE_SHARED_MODULE_SONAME_CXX_FLAG}" )
endif()
set( CMAKE_SYCL_CREATE_SHARED_MODULE
   "${CMAKE_SYCL_HOST_LINKER} <CMAKE_SHARED_MODULE_SYCL_FLAGS> <LANGUAGE_COMPILE_FLAGS> <LINK_FLAGS> <CMAKE_SHARED_MODULE_CREATE_SYCL_FLAGS> -o <TARGET> <OBJECTS> <LINK_LIBRARIES>" )

# Set up how executable building shoul go.
if( NOT DEFINED CMAKE_SYCL_LINK_FLAGS )
   set( CMAKE_SYCL_LINK_FLAGS
      "${CMAKE_CXX_LINK_FLAGS} -fsycl -fsycl-targets=${CMAKE_SYCL_TARGETS}" )
endif()
if( NOT DEFINED CMAKE_EXECUTABLE_RUNTIME_SYCL_FLAG )
   set( CMAKE_EXECUTABLE_RUNTIME_SYCL_FLAG
      "${CMAKE_EXECUTABLE_RUNTIME_CXX_FLAG}" )
endif()
if( NOT DEFINED CMAKE_EXECUTABLE_RUNTIME_SYCL_FLAG_SEP )
   set( CMAKE_EXECUTABLE_RUNTIME_SYCL_FLAG_SEP
      "${CMAKE_EXECUTABLE_RUNTIME_CXX_FLAG_SEP}" )
endif()
if( NOT DEFINED CMAKE_EXECUTABLE_RPATH_LINK_SYCL_FLAG )
   set( CMAKE_EXECUTABLE_RPATH_LINK_SYCL_FLAG
      "${CMAKE_EXECUTABLE_RPATH_LINK_CXX_FLAG}" )
endif()
set( CMAKE_SYCL_LINK_EXECUTABLE
   "${CMAKE_SYCL_HOST_LINKER} <FLAGS> <CMAKE_SYCL_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>" )

# Set up the default flags for the SYCL build.
set( CMAKE_SYCL_FLAGS_INIT "$ENV{SYCLFLAGS} ${CMAKE_SYCL_FLAGS_INIT}" )
cmake_initialize_per_config_variable( CMAKE_SYCL_FLAGS
   "Flags used by the SYCL compiler" )

# Tell CMake that the information was loaded.
set( CMAKE_SYCL_INFORMATION_LOADED TRUE )
