# Force static linkage (DLL exports are not properly configured)
vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

# Download and extract the source
vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL https://gitlab.com/10Duke/core/cpp-core.git
    REF 6bb0eed859d99837c3091f3a238bf3e05ed847b5
    HEAD_REF main
    PATCHES
    use-find-package-nlohmann-json.patch
)

# Configure CMake
# Force CMake configs to install in share/ instead of lib/cmake/
vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
    -DBUILD_TESTING=OFF
    -DBUILD_TEST_UTILS=OFF
    -DBUILD_SHARED_LIBS=OFF
)

# Build and install
vcpkg_cmake_install()

# Now all CMake configs should be in share/ already
# Fix the paths in the config files
set(PACKAGES tenduke_core tenduke_oidc tenduke_oidc_device tenduke_oidc_osbrowser tenduke_services tenduke_services_impl)
set(package_index 0)
foreach(package ${PACKAGES})
    if(EXISTS "${CURRENT_PACKAGES_DIR}/share/${package}")
        math(EXPR package_index "${package_index} + 1")
        message(STATUS "Calling vcpkg_cmake_config_fixup for ${package} (${package_index}/${list_length})...")
        vcpkg_cmake_config_fixup(PACKAGE_NAME ${package} CONFIG_PATH share/${package})
    endif()
endforeach()

# Remove duplicate files in debug
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

# Copy usage file
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
