cmake_minimum_required(VERSION 3.15)
project(Tutorial VERSION 1.0)

add_library(exe_compiler_flags INTERFACE)
target_compile_features(exe_compiler_flags INTERFACE cxx_std_11)

# Generator expressions (Genex) = $<...> = are evaluated during system generation

# COMPILE_LANG_AND_ID = language and compiler id
# if(language = CXX && (compiler_id<CXX> = ARMClang || compiler_id<CXX> = AppleClang) || ....) { return 1 } else { return 0 }

# $<COMPILE_LANG_AND_ID:language,compiler_ids>
set(gcc_like_cxx "$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU,LCC>")
set(msvc_cxx "$<COMPILE_LANG_AND_ID:CXX,MSVC>")

# BUILD_INTERFACE = Keyword is used in generator expressions to specify options that are applied only during the generation of build files, not during the actual build process
target_compile_options(exe_compiler_flags INTERFACE
  "$<${gcc_like_cxx}:$<BUILD_INTERFACE:-Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused>>"
  "$<${msvc_cxx}:$<BUILD_INTERFACE:-W3>>"
)

configure_file(TutorialConfig.h.in TutorialConfig.h)

add_subdirectory(MathFunctions)

add_executable(exe tutorial.cxx)

target_link_libraries(exe PUBLIC MathFunctions exe_compiler_flags)

target_include_directories(exe PUBLIC
                           "${PROJECT_BINARY_DIR}"
                           )
