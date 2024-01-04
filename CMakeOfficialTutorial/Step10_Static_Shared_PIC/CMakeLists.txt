cmake_minimum_required(VERSION 3.15)
project(Tutorial VERSION 1.0)

add_library(exe_compiler_flags INTERFACE)
target_compile_features(exe_compiler_flags INTERFACE cxx_std_11)

set(gcc_like_cxx "$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU,LCC>")
set(msvc_cxx "$<COMPILE_LANG_AND_ID:CXX,MSVC>")
target_compile_options(exe_compiler_flags INTERFACE
  "$<${gcc_like_cxx}:$<BUILD_INTERFACE:-Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused>>"
  "$<${msvc_cxx}:$<BUILD_INTERFACE:-W3>>"
)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
option(BUILD_SHARED_LIBS "Build using shared libraries" ON)

#Error when BUILD_SHARED_LIBS - ON
#Fix error:
# /usr/bin/ld: ../libSqrtLibrary.a(mysqrt.cxx.o): warning: relocation against `_ZSt4cout@@GLIBCXX_3.4' in read-only section `.text'
# /usr/bin/ld: ../libSqrtLibrary.a(mysqrt.cxx.o): relocation R_X86_64_PC32 against symbol `_ZSt4cout@@GLIBCXX_3.4' can not be used when making a shared object; recompile with -fPIC
# /usr/bin/ld: final link failed: bad value
# collect2: error: ld returned 1 exit status
# gmake[2]: *** [MathFunctions/CMakeFiles/MathFunctions.dir/build.make:98: libMathFunctions.so] Error 1
# gmake[1]: *** [CMakeFiles/Makefile2:886: MathFunctions/CMakeFiles/MathFunctions.dir/all] Error 2
# gmake: *** [Makefile:166: all] Error 2

# global fix for all 
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC") 


configure_file(TutorialConfig.h.in TutorialConfig.h)

add_subdirectory(MathFunctions)

add_executable(exe tutorial.cxx)
target_link_libraries(exe PUBLIC MathFunctions exe_compiler_flags)

target_include_directories(exe PUBLIC
                           "${PROJECT_BINARY_DIR}"
                           )

install(TARGETS exe DESTINATION bin)
install(FILES "${PROJECT_BINARY_DIR}/TutorialConfig.h"
  DESTINATION include
  )

include(CTest)

add_test(NAME Runs COMMAND exe 25)

# does the usage message work?
add_test(NAME Usage COMMAND exe)
set_tests_properties(Usage
  PROPERTIES PASS_REGULAR_EXPRESSION "Usage:.*number"
  )

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

# setup installer
include(InstallRequiredSystemLibraries)
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/License.txt")
set(CPACK_PACKAGE_VERSION_MAJOR "${Tutorial_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${Tutorial_VERSION_MINOR}")
set(CPACK_SOURCE_GENERATOR "TGZ")
include(CPack)