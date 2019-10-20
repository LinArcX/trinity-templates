CMAKE_MINIMUM_REQUIRED(VERSION 2.6)
PROJECT({[project_name]})

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include_directories(src)
file(GLOB SOURCES core/*.cpp pages/*.cpp util/*.cpp)
file(GLOB HEADERS src/*.h pages/*.h util/*.h)

ADD_EXECUTABLE({[project_name]} ${SOURCES} ${HEADERS})

FIND_PACKAGE(PkgConfig REQUIRED)
PKG_CHECK_MODULES({[project_name]} REQUIRED {[libs]})

# Tell the compiler where to look for headers and to the linker where to look for libraries
INCLUDE_DIRECTORIES(${{[project_name]}_INCLUDE_DIRS})
LINK_DIRECTORIES(${{[project_name]}_LIBRARY_DIRS})

# Add other flags to the compiler
ADD_DEFINITIONS(${{[project_name]}_CFLAGS_OTHER})

# Link the target against the {[project_name]}.0 libraries
TARGET_LINK_LIBRARIES({[project_name]} ${{[project_name]}_LIBRARIES} pthread)

set_target_properties({[project_name]} PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY_DEBUG   ${CMAKE_SOURCE_DIR}/debug
  RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_SOURCE_DIR}/release
)
