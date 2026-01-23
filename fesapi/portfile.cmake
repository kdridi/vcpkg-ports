vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO F2I-Consulting/fesapi
    REF "v${VERSION}"
    SHA512 83823e3ce3acfc1428f5d0fa8fd96dd49befce3e2f8827b4894403b215f9ef117bcd55af981c33fc019cc5bfeac76c62265fc052285307fbabe2630d91bba14d
    HEAD_REF fesapi
    PATCHES
        fix-configure-file.patch
)

# Pre-create version_config.h to avoid parallel build issues
file(READ "${SOURCE_PATH}/cmake/version_config.h.in" VERSION_CONFIG_IN)
string(REPLACE "\${Fesapi_VERSION_MAJOR}" "2" VERSION_CONFIG_IN "${VERSION_CONFIG_IN}")
string(REPLACE "\${Fesapi_VERSION_MINOR}" "14" VERSION_CONFIG_IN "${VERSION_CONFIG_IN}")
string(REPLACE "\${Fesapi_VERSION_PATCH}" "0" VERSION_CONFIG_IN "${VERSION_CONFIG_IN}")
string(REPLACE "\${Fesapi_VERSION_TWEAK}" "0" VERSION_CONFIG_IN "${VERSION_CONFIG_IN}")
string(REPLACE "\${Fesapi_VERSION}" "2.14.0.0" VERSION_CONFIG_IN "${VERSION_CONFIG_IN}")
file(WRITE "${SOURCE_PATH}/src/version_config.h" "${VERSION_CONFIG_IN}")

# Pre-create HidtType.h for HDF5 >= 1.10 (default case)
file(READ "${SOURCE_PATH}/cmake/HidtType.h.in" HIDTTYPE_IN)
string(REPLACE "\${COMMENT_HDF5_1_8}" "//" HIDTTYPE_IN "${HIDTTYPE_IN}")
string(REPLACE "\${COMMENT_HDF5_1_10}" "" HIDTTYPE_IN "${HIDTTYPE_IN}")
file(WRITE "${SOURCE_PATH}/src/common/HidtType.h" "${HIDTTYPE_IN}")

# Pre-create nsDefinitions.h with default namespace values
file(READ "${SOURCE_PATH}/cmake/nsDefinitions.h" NS_DEFINITIONS_IN)
string(REPLACE "\${FESAPI_COMMON_NS}" "common" NS_DEFINITIONS_IN "${NS_DEFINITIONS_IN}")
string(REPLACE "\${FESAPI_RESQML2_NS}" "resqml2" NS_DEFINITIONS_IN "${NS_DEFINITIONS_IN}")
string(REPLACE "\${FESAPI_RESQML2_0_1_NS}" "resqml2_0_1" NS_DEFINITIONS_IN "${NS_DEFINITIONS_IN}")
string(REPLACE "\${FESAPI_RESQML2_2_NS}" "resqml2_2" NS_DEFINITIONS_IN "${NS_DEFINITIONS_IN}")
string(REPLACE "\${FESAPI_WITSML2_NS}" "witsml2" NS_DEFINITIONS_IN "${NS_DEFINITIONS_IN}")
string(REPLACE "\${FESAPI_WITSML2_1_NS}" "witsml2_1" NS_DEFINITIONS_IN "${NS_DEFINITIONS_IN}")
string(REPLACE "\${FESAPI_PRODML2_3_NS}" "prodml2_3" NS_DEFINITIONS_IN "${NS_DEFINITIONS_IN}")
string(REPLACE "\${FESAPI_EML2_NS}" "eml2" NS_DEFINITIONS_IN "${NS_DEFINITIONS_IN}")
string(REPLACE "\${FESAPI_EML2_0_NS}" "eml2_0" NS_DEFINITIONS_IN "${NS_DEFINITIONS_IN}")
string(REPLACE "\${FESAPI_EML2_3_NS}" "eml2_3" NS_DEFINITIONS_IN "${NS_DEFINITIONS_IN}")
file(WRITE "${SOURCE_PATH}/src/nsDefinitions.h" "${NS_DEFINITIONS_IN}")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")