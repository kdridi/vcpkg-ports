# Force static linkage to match tenduke-core
vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

# Download and extract the source
vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL https://gitlab.com/10Duke/enterprise/cpp/licensing-client.git
    REF b286bdc9ec5f96bf449e57af428f4d882d0ebf91
    HEAD_REF main
)

# Determine if examples should be built
set(BUILD_EXAMPLES OFF)
if("examples" IN_LIST FEATURES)
    set(BUILD_EXAMPLES ON)
endif()

# Configure CMake
vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_EXAMPLES=${BUILD_EXAMPLES}
        -DBUILD_TESTING=OFF
        -DBUILD_SHARED_LIBS=OFF
)

# Build and install
vcpkg_cmake_install()

# Fix CMake config files that are installed in lib/cmake/ instead of share/
# Process both packages
set(PACKAGES tenduke_client_ee tenduke_client_ee_bundle)
list(LENGTH PACKAGES num_packages)
math(EXPR last_index "${num_packages} - 1")
foreach(index RANGE 0 ${last_index})
    list(GET PACKAGES ${index} package)
    if(EXISTS "${CURRENT_PACKAGES_DIR}/lib/cmake/${package}")
        if(${index} EQUAL ${last_index})
            # Last package - allow deletion of parent directory
            vcpkg_cmake_config_fixup(PACKAGE_NAME ${package} CONFIG_PATH lib/cmake/${package})
        else()
            # Not last package - preserve parent directory for subsequent packages
            vcpkg_cmake_config_fixup(PACKAGE_NAME ${package} CONFIG_PATH lib/cmake/${package} DO_NOT_DELETE_PARENT_CONFIG_PATH)
        endif()
    endif()
endforeach()

# Remove duplicate files in debug
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Remove residual dist/ directories if any (not part of standard vcpkg layout)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/dist")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/dist")

# Handle copyright
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

# Copy usage file
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
