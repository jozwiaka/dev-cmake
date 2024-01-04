cmake_minimum_required(VERSION 3.20)
project(ProjectName VERSION 1.0.0 LANGUAGES C CXX)

add_library(exe_compiler_flags INTERFACE)
target_compile_features(exe_compiler_flags INTERFACE cxx_std_11)

#CMAKE_* = CMAKE variables
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/")
include(AddGitSubmodule)
add_git_submodule(external/json)

add_subdirectory(configured)
add_subdirectory(external)
add_subdirectory(src)
add_subdirectory(app)

