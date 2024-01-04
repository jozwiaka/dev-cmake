#!/bin/bash
rm -rf build
mkdir build
cd build
cmake .. || exit
cmake --build . || exit
./app/exe
