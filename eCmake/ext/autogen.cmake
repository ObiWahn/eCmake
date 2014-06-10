set(TNAME @TNAME@)

cmake_minimum_required(VERSION 2.8.11)
project(${TNAME})

set(TEP_BASE "${CMAKE_BINARY_DIR}")
set_property(DIRECTORY PROPERTY EP_BASE "${TEP_BASE}")

set(TSOURCE "${CMAKE_SOURCE_DIR}/../src/${TNAME}")
set(TSTAMP  "${CMAKE_SOURCE_DIR}/../stamp/${TNAME}")
set(TBUILD  "${TEP_BASE}/build/${TNAME}")

include(ExternalProject)
ExternalProject_Add(${TNAME}
    STAMP_DIR         "${TSTAMP}"
    DOWNLOAD_DIR      "${TSOURCE}"
    SOURCE_DIR        "${TSOURCE}"
    BUILD_IN_SOURCE   0

    GIT_REPOSITORY    @TREPO@
    GIT_TAG           master

    UPDATE_COMMAND    git clean -f
    UPDATE_COMMAND    git pull

    CONFIGURE_COMMAND "${TSOURCE}/configure" "--prefix=${E18_PRE}" @TCONFIGURE_FLAGS@

    BUILD_COMMAND     "make" "-j6"
    INSTALL_COMMAND   "make" "install"
)

ExternalProject_Add_Step(${TNAME} autogen
  COMMAND "${TSOURCE}/autogen.sh"
  DEPENDEES download
  DEPENDERS configure
  WORKING_DIRECTORY "${TSOURCE}"
)
