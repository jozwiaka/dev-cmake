add_library(MyLib STATIC MyLib.cpp)

target_include_directories(MyLib INTERFACE
    ${CMAKE_CURRENT_SOURCE_DIR} # = "./"
)

target_include_directories(MyLib PUBLIC
    "${CMAKE_BINARY_DIR}/configured_files/include"
)