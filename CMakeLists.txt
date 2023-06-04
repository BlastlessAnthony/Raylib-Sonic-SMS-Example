cmake_minimum_required(VERSION 3.0.0 FATAL_ERROR)
project(
    Sonic-SMS-Example
    VERSION 1.0.0
    DESCRIPTION "Its an example for raylib that proves that the library is capable of creating \"commercial\" games."
    HOMEPAGE_URL "https://github.com/BlastlessAnthony/Raylib-Sonic-SMS-Example"
    LANGUAGES C
)


set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_LIST_DIR}/CMake")


#Project directories.
set(PROJECT_SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/Source")
set(PROJECT_INCLUDE_DIR "${PROJECT_SOURCE_DIR}/Include")
set(PROJECT_RESOURCES_DIR "${CMAKE_CURRENT_LIST_DIR}/Assets")

#
set(PROJECT_SOURCES
    "${PROJECT_SOURCE_DIR}/Game.c"
)

set(PROJECT_RESOURCES

)

#The real "meat and potatos"
add_executable(${PROJECT_NAME} ${PROJECT_SOURCES} ${PROJECT_RESOURCES})
