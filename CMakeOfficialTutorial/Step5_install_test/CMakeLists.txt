cmake_minimum_required(VERSION 3.15)
project(Tutorial VERSION 1.0)

add_library(exe_compiler_flags INTERFACE)
target_compile_features(exe_compiler_flags INTERFACE cxx_std_11)

# add compiler warning flags just when building this project via
# the BUILD_INTERFACE genex
set(gcc_like_cxx "$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU,LCC>")
set(msvc_cxx "$<COMPILE_LANG_AND_ID:CXX,MSVC>")
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

install(TARGETS exe DESTINATION bin)
install(FILES "${PROJECT_BINARY_DIR}/TutorialConfig.h" DESTINATION include)

enable_testing()

add_test(NAME Runs COMMAND exe 25)

add_test(NAME Usage COMMAND exe)
set_tests_properties(Usage PROPERTIES PASS_REGULAR_EXPRESSION "Usage:.*number")

add_test(NAME StandardUse COMMAND exe 4)
set_tests_properties(StandardUse PROPERTIES PASS_REGULAR_EXPRESSION "4 is 2")

function(do_test target arg result)
  add_test(NAME Comp${arg} COMMAND ${target} ${arg})
  set_tests_properties(Comp${arg}
  PROPERTIES PASS_REGULAR_EXPRESSION ${result}
  )
endfunction()

do_test(exe 4 "4 is 2")
do_test(exe 9 "9 is 3")
do_test(exe 5 "5 is 2.236")
do_test(exe 7 "7 is 2.645")
do_test(exe 25 "25 is 5")
do_test(exe -25 "-25 is (-nan|nan|0)")
do_test(exe 0.0001 "0.0001 is 0.01")