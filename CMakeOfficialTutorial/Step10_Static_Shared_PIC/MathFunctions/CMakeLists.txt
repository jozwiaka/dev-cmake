# BUILD_SHARED_LIBS=ON -> MathFunctions.a
# BUILD_SHARED_LIBS=OFF -> MathFunctions.a
# add_library(MathFunctions STATIC MathFunctions.cxx)

# Without specifing the STATIC/DYNAMIC libs are STATIC by default
# BUILD_SHARED_LIBS=ON -> MathFunctions.so
# BUILD_SHARED_LIBS=OFF -> MathFunctions.a
add_library(MathFunctions MathFunctions.cxx)

target_include_directories(MathFunctions
                           INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
                           )

option(USE_MYMATH "Use tutorial provided math implementation" ON)
if(USE_MYMATH)

  target_compile_definitions(MathFunctions PRIVATE "USE_MYMATH")

  include(MakeTable.cmake) # generates Table.h

  # SqrtLibrary has to be static (.a), because we want to pack it to MathFunctions.so
  # if we remove SqrtLibrary.a after buidling the project, exe will still work because MathFunctions.so includes whole SqrtLibrary.a
  add_library(SqrtLibrary STATIC
              mysqrt.cxx
              ${CMAKE_CURRENT_BINARY_DIR}/Table.h
              )

  # state that we depend on our binary dir to find Table.h
  target_include_directories(SqrtLibrary PRIVATE
                             ${CMAKE_CURRENT_BINARY_DIR}
                             )

  target_link_libraries(SqrtLibrary PUBLIC exe_compiler_flags)
  target_link_libraries(MathFunctions PRIVATE SqrtLibrary)
  # Fix: state that SqrtLibrary need PIC when the default is shared libraries
  set_target_properties(SqrtLibrary PROPERTIES
  POSITION_INDEPENDENT_CODE ${BUILD_SHARED_LIBS}
  )
endif()

target_link_libraries(MathFunctions PUBLIC exe_compiler_flags)
# define the symbol stating we are using the declspec(dllexport) when building on windows
target_compile_definitions(MathFunctions PRIVATE "EXPORTING_MYMATH")

set(installable_libs MathFunctions exe_compiler_flags)
if(TARGET SqrtLibrary)
  list(APPEND installable_libs SqrtLibrary)
endif()
install(TARGETS ${installable_libs} DESTINATION lib)
install(FILES MathFunctions.h DESTINATION include)
