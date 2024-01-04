Remove-Item -Recurse -Force debug, release

New-Item -ItemType Directory -Path debug
New-Item -ItemType Directory -Path release

Set-Location debug
cmake -G "Visual Studio 17 2022" -DCMAKE_BUILD_TYPE=DEBUG ..
cmake --build .

Set-Location ../release
cmake -G "Visual Studio 17 2022" -DCMAKE_BUILD_TYPE=RELEASE ..
cmake --build .

Set-Location ..
cpack --config MultiCPackConfig.cmake