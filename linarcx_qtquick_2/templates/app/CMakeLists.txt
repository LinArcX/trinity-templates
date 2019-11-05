CMAKE_MINIMUM_REQUIRED(VERSION 2.6)
PROJECT({[PROJECT_NAME]})

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include_directories(src)
file(GLOB SOURCES core/*.cpp pages/*.cpp util/*.cpp)
file(GLOB HEADERS src/*.h pages/*.h util/*.h)

ADD_EXECUTABLE({[PROJECT_NAME]} ${SOURCES} ${HEADERS})

FIND_PACKAGE(PkgConfig REQUIRED)
PKG_CHECK_MODULES({[PROJECT_NAME]} REQUIRED {[libs]})

# Tell the compiler where to look for headers and to the linker where to look for libraries
INCLUDE_DIRECTORIES(${{[PROJECT_NAME]}_INCLUDE_DIRS})
LINK_DIRECTORIES(${{[PROJECT_NAME]}_LIBRARY_DIRS})

# Add other flags to the compiler
ADD_DEFINITIONS(${{[PROJECT_NAME]}_CFLAGS_OTHER})

# Link the target against the {[PROJECT_NAME]}.0 libraries
TARGET_LINK_LIBRARIES({[PROJECT_NAME]} ${{[PROJECT_NAME]}_LIBRARIES} pthread)

set_target_properties({[PROJECT_NAME]} PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY_DEBUG   ${CMAKE_SOURCE_DIR}/debug
  RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_SOURCE_DIR}/release
)
