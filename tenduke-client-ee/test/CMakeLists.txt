cmake_minimum_required(VERSION 3.20)
project(test_tenduke_client_ee)

# Require C++11 for tenduke-client-ee compatibility
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

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
