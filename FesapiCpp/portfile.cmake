vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO F2I-Consulting/fesapi
	REF "v${VERSION}"
	SHA512 1ccbcef17f484f1aebbfff0347fd4aaf51d86d9389645cf2059cc6d47d69863c9bde368df438ac7d9146c6dd111d1da6bac1910146977629ff0a7cddb5848a08
	HEAD_REF master
	PATCHES
		fix-configure-file.patch
)

# DISABLE_PARALLEL_CONFIGURE is required because FESAPI's CMake
# writes generated files to the source directory, causing conflicts
# between Debug and Release parallel builds.
if (VCPKG_LIBRARY_LINKAGE STREQUAL "static")
	set(FESAPI_STATIC_CMAKE_OPTIONS -DHDF5_USE_STATIC_LIBRARIES=ON -DZLIB_USE_STATIC_LIBS=ON)
endif ()

vcpkg_cmake_configure(
	SOURCE_PATH "${SOURCE_PATH}"
	DISABLE_PARALLEL_CONFIGURE
	OPTIONS ${FEATURE_OPTIONS} ${FESAPI_STATIC_CMAKE_OPTIONS}
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(
	CONFIG_PATH lib/cmake/FesapiCpp
)

vcpkg_install_copyright(
	FILE_LIST
	"${SOURCE_PATH}/LICENSE"
)

# Clean up debug files
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
