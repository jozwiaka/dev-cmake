#include <iostream>
#include "MyLib.hpp"
#include "Config.hpp"

void MyLib::print()
{
    std::cout << Config::project_name << "\n";
    std::cout << Config::project_version_major << "\n";
}