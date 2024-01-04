# dir = arg0
function(add_git_submodule dir)
    find_package(Git REQUIRED)
    if(NOT EXISTS ${dir}/CMakeLists.txt)
    # try to pull/update changes which may contain CMakeLists.txt
    # git submodule update
        execute_process(COMMAND
        ${GIT_EXECUTABLE} submodule update --init --recursive -- ${dir}
            WORKING_DIRECTORY ${PROJECT_SOURCE_DIR})
    endif()
    add_subdirectory(${dir})
endfunction(add_git_submodule)