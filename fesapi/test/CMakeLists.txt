cmake_minimum_required(VERSION 3.15)
project(test_fesapi)

# Require C++17 for FESAPI compatibility
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find required packages
find_package(FesapiCpp CONFIG REQUIRED)

message(STATUS "FESAPI found: ${FesapiCpp_DIR}")
message(STATUS "FESAPI version: ${FesapiCpp_VERSION}")

# Create test executable
add_executable(test_app main.cpp)
target_link_libraries(test_app PRIVATE FesapiCpp)
