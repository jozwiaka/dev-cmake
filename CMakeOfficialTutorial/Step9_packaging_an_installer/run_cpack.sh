#!/bin/bash
rm -rf build
mkdir -p build
cd build
cmake .. || exit 1
cmake --build . || exit 1
./exe 5
cpack
./*.sh || exit 1 #accept yy
./Tutorial-1.0-Linux/bin/exe || exit 1
