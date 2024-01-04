#!/bin/bash
rm -rf build
mkdir -p build
cd build
cmake .. || exit 1
cmake --build . || exit 1
./exe 5
cpack
