#include <iostream>
#include "MyLib.hpp"
#include "Config.hpp"
#include <nlohmann/json.hpp>

int main(int argc, char *argv[])
{
    MyLib::print();

    // PUBLIC so I can use Config namespace:
    // target_include_directories(MyLib PUBLIC
    // "${CMAKE_BINARY_DIR}/configured_files/include"
    // )
    std::cout << Config::project_version_patch << "\n";

    std::cout << "JSON Lib Version:" << NLOHMANN_JSON_VERSION_MAJOR << "." << NLOHMANN_JSON_VERSION_MINOR << "." << NLOHMANN_JSON_VERSION_PATCH << "\n";
}