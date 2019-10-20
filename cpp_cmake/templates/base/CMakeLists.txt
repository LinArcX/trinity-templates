CMAKE_MINIMUM_REQUIRED(VERSION 2.6)
PROJECT(neo-dm)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include_directories(src)
file(GLOB SOURCES core/*.cpp pages/*.cpp util/*.cpp)
file(GLOB HEADERS src/*.h pages/*.h util/*.h)

ADD_EXECUTABLE(neo-dm ${SOURCES} ${HEADERS})

FIND_PACKAGE(PkgConfig REQUIRED)
PKG_CHECK_MODULES(neo-dm REQUIRED ncursesw menuw)

# Tell the compiler where to look for headers and to the linker where to look for libraries
INCLUDE_DIRECTORIES(${neo-dm_INCLUDE_DIRS})
LINK_DIRECTORIES(${neo-dm_LIBRARY_DIRS})

# Add other flags to the compiler
ADD_DEFINITIONS(${neo-dm_CFLAGS_OTHER})

# Link the target against the neo-dm.0 libraries
TARGET_LINK_LIBRARIES(neo-dm ${neo-dm_LIBRARIES} pthread)

set_target_properties(neo-dm PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY_DEBUG   ${CMAKE_SOURCE_DIR}/debug
  RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_SOURCE_DIR}/release
)
