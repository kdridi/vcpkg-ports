cmake_minimum_required(VERSION 3.20)
project(test_tenduke_client_ee)

# Use C++20 to match modern project requirements
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Find required packages
find_package(tenduke_client_ee_bundle CONFIG REQUIRED)
find_package(tenduke_client_ee CONFIG REQUIRED)

message(STATUS "tenduke_client_ee_bundle found")
message(STATUS "tenduke_client_ee found")

# Create test executable
add_executable(test_app main.cpp)
target_link_libraries(test_app PRIVATE
    tenduke::tenduke_client_ee_bundle
    tenduke::tenduke_client_ee
)
