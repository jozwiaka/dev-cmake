#!/bin/bash
rm -rf debug release
mkdir debug release
cd debug
cmake -DCMAKE_BUILD_TYPE=Debug ..
cmake --build .
cd ../release
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .
cd ..
cpack --config MultiCPackConfig.cmake
