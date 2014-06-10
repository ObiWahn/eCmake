#### Compiler Settings ##############################################
## must be at the beginning!!!
set(CMAKE_CXX_FLAGS              "-Wall")
set(CMAKE_CXX_FLAGS_DEBUG        "-g")

set(CMAKE_C_FLAGS                "-Wall")
set(CMAKE_C_FLAGS_DEBUG          "-g")

#### Basic Settings #################################################
cmake_minimum_required(VERSION 2.8.12)
project(e18)

#### Common Modules #################################################
##c++11 check
include(CheckCXXCompilerFlag)
CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
if(COMPILER_SUPPORTS_CXX11)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11" )
    if ("${CMAKE_CXX_COMPILER}" MATCHES "clang")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libstdc++")
    endif ()
else()
    message(STATUS "The compiler ${CMAKE_CXX_COMPILER} has no C++11
                    support. Please use a different C++ compiler.")
endif(COMPILER_SUPPORTS_CXX11)


#### Extra Modules ##################################################
#allow Loading of Modules in extra paths
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/ext)


set(E18_PRE $ENV{E18_PRE})
set(E18_LIB "${E18_PRE}/lib")
set(E18_INC "${E18_PRE}/include")
set(E18_BIN "${E18_PRE}/bin")


set(TNAME "core_efl")
set(TREPO "git://git.enlightenment.org/core/efl.git")
set(TBRANCH "master")
set(TCONFIGURE_FLAGS "--enable-systemd" "--with-systemdunitdir=${E18_PRE}/systemd_unit")
include(autogen REQUIRED)

set(TNAME "core_loaders")
set(TREPO "git://git.enlightenment.org/core/evas_generic_loaders.git")
set(TBRANCH "master")
set(TCONFIGURE_FLAGS "")
include(autogen REQUIRED)

set(TNAME "core_players")
set(TREPO "git://git.enlightenment.org/core/emotion_generic_players.git")
set(TBRANCH "master")
set(TCONFIGURE_FLAGS "")
include(autogen REQUIRED)

set(TNAME "core_elementary")
set(TREPO "git://git.enlightenment.org/core/elementary.git")
set(TBRANCH "master")
set(TCONFIGURE_FLAGS "")
include(autogen REQUIRED)

set(TNAME "core_enlightenment")
set(TREPO "git://git.enlightenment.org/core/enlightenment.git")
set(TBRANCH "master")
set(TCONFIGURE_FLAGS "--enable-systemd" "--disable-pulseaudio"  "--with-systemdunitdir=${E18_PRE}/systemd_unit")
include(autogen REQUIRED)


add_dependencies(core_loaders core_efl)
add_dependencies(core_players core_efl)
add_dependencies(core_elementary core_loaders core_players)
add_dependencies(core_enlightenment core_elementary)
