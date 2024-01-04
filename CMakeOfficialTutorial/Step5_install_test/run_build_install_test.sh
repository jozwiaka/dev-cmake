#!/bin/bash
rm -rf build
mkdir -p build
cd build
cmake .. || exit 1
cmake --build . || exit 1
cmake --install . || exit 1
# Output:
# -- Install configuration: ""
# -- Installing: /usr/local/lib/libMathFunctions.a
# -- Installing: /usr/local/lib/libSqrtLibrary.a
# -- Installing: /usr/local/include/MathFunctions.h
# -- Installing: /usr/local/bin/exe
# -- Installing: /usr/local/include/TutorialConfig.h
printf "INSTALLED SUCCESSFULLY\n"
printf "\n\n### LIST OF TESTS ###\n"
ctest -N
printf "\n\n### RUN TESTS ###:\n"
ctest -VV
# /usr/local/bin/exe

# For multi-configuration tools, don't forget to use the --config argument to specify the configuration.
# cmake --install . --config Release

# If using an IDE, simply build the INSTALL target. You can build the same install target from the command line like the following:
# cmake --build . --target install --config Debug

# The CMake variable CMAKE_INSTALL_PREFIX is used to determine the root of where the files will be installed. If using the cmake --install command, the installation prefix can be overridden via the --prefix argument. For example:
# cmake --install . --prefix "/home/myuser/installdir"
