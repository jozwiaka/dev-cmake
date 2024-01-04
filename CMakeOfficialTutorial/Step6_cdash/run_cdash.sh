#!/bin/bash
rm -rf build
mkdir -p build
cd build
cmake .. || exit 1
printf "############################\n"
ctest [-VV] -D Experimental || exit 1
# see ./CTestConfig.cmake
# https://my.cdash.org/index.php?project=CMakeTutorial
