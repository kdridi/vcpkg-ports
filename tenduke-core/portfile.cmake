# Force static linkage (DLL exports are not properly configured)
vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

# Download and extract the source
vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL https://gitlab.com/10Duke/core/cpp-core.git
    REF 49afbd70e78ceed4d70d0c0f4f3e101b293ecc54
    FETCH_REF "v${VERSION}"
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

# Fix CMake config files that are installed in lib/cmake/ instead of share/
# Process each package separately
set(PACKAGES tenduke_core tenduke_oidc tenduke_oidc_device tenduke_oidc_osbrowser tenduke_services tenduke_services_impl)
list(LENGTH PACKAGES num_packages)
math(EXPR last_index "${num_packages} - 1")
foreach(index RANGE 0 ${last_index})
    list(GET PACKAGES ${index} package)
    if(${index} EQUAL ${last_index})
        # Last package - allow deletion of parent directory
        vcpkg_cmake_config_fixup(PACKAGE_NAME ${package} CONFIG_PATH lib/cmake/${package})
    else()
        # Not last package - preserve parent directory for subsequent packages
        vcpkg_cmake_config_fixup(PACKAGE_NAME ${package} CONFIG_PATH lib/cmake/${package} DO_NOT_DELETE_PARENT_CONFIG_PATH)
    endif()
endforeach()

# Remove duplicate files in debug
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Remove residual dist/ directories (not part of standard vcpkg layout)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/dist")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/dist")

# Handle copyright
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

# Copy usage file
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
