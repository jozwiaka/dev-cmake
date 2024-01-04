cmake_minimum_required(VERSION 3.20)
project(ProjectName VERSION 1.0.0)

add_library(exe_compiler_flags INTERFACE)
target_compile_features(exe_compiler_flags INTERFACE cxx_std_11)
add_executable(exe main.cpp)
target_link_libraries(exe PRIVATE exe_compiler_flags)

include(${CMAKE_BINARY_DIR}/conan_toolchain.cmake)
set(CMAKE_BUILD_TYPE Release)

# Print all CMake variables
message("JozwiakA: CMAKE_BINARY_DIR = ${CMAKE_BINARY_DIR}")
message("JozwiakA: CMAKE_SOURCE_DIR = ${CMAKE_SOURCE_DIR}")
message("JozwiakA: CMAKE_CURRENT_BINARY_DIR = ${CMAKE_CURRENT_BINARY_DIR}")
message("JozwiakA: CMAKE_CURRENT_SOURCE_DIR = ${CMAKE_CURRENT_SOURCE_DIR}")
message("JozwiakA: CMAKE_CXX_FLAGS = ${CMAKE_CXX_FLAGS}")
message("JozwiakA: CMAKE_CXX_COMPILER = ${CMAKE_CXX_COMPILER}")
message("JozwiakA: CMAKE_CXX_COMPILER_ID = ${CMAKE_CXX_COMPILER_ID}")
message("JozwiakA: CMAKE_BUILD_TYPE = ${CMAKE_BUILD_TYPE}")
message("JozwiakA: CMAKE_INSTALL_PREFIX = ${CMAKE_INSTALL_PREFIX}")
message("JozwiakA: CMAKE_MODULE_PATH = ${CMAKE_MODULE_PATH}")
message("JozwiakA: CMAKE_SYSTEM_NAME = ${CMAKE_SYSTEM_NAME}")
message("JozwiakA: CMAKE_SYSTEM_VERSION = ${CMAKE_SYSTEM_VERSION}")

find_package(ZLIB REQUIRED)
if (ZLIB_FOUND)
    message("JozwiakA: ZLIB found.")
    message("JozwiakA: ZLIB root: ${ZLIB_ROOT}")
    message("JozwiakA: ZLIB version: ${ZLIB_VERSION_STRING}")
    message("JozwiakA: ZLIB include directories: ${ZLIB_INCLUDE_DIRS}")
    message("JozwiakA: ZLIB libraries: ${ZLIB_LIBRARIES}")
    message("JozwiakA: ZLIB library: ${ZLIB_LIBRARY}")

    include_directories(${ZLIB_INCLUDE_DIRS}) #It is not needed it I think
    target_link_libraries(exe PRIVATE ${ZLIB_LIBRARIES})
else()
    message(FATAL_ERROR "ZLIB not found!")
endif()

find_package(OPENSSL REQUIRED)
if (OPENSSL_FOUND)
    message("JozwiakA: OPENSSL found.")
    message("JozwiakA: OPENSSL root: ${OPENSSL_ROOT}")
    message("JozwiakA: OPENSSL version: ${OPENSSL_VERSION_STRING}")
    message("JozwiakA: OPENSSL include directories: ${OPENSSL_INCLUDE_DIRS}")
    message("JozwiakA: OPENSSL libraries: ${OPENSSL_LIBRARIES}")
    message("JozwiakA: OPENSSL library: ${OPENSSL_LIBRARY}") #openssl::openssl
    # openssl::openssl =  OpenSSL::Crypto OpenSSL::SSL
    # package          =  Copmponent1     Component2

    include_directories(${OPENSSL_INCLUDE_DIRS}) #It is not needed it I think
    target_link_libraries(exe PRIVATE ${OPENSSL_LIBRARIES})
else()
    message(FATAL_ERROR "OPENSSL not found!")
endif()