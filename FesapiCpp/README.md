# FesapiCpp

[Vcpkg](https://github.com/microsoft/vcpkg) port for [FESAPI](https://github.com/F2I-Consulting/fesapi) - Energistics data standards support library.

## Overview

FESAPI is a C++ library that provides support for Energistics data standards, primarily:
- **RESQML™** - Reservoir reservoir description
- **WITSML™** - Wellsite data
- **PRODML™** - Production data

## Package Information

| Property | Value |
|----------|-------|
| **Version** | 2.13.0.0 |
| **License** | Apache-2.0 |
| **Homepage** | https://github.com/F2I-Consulting/fesapi |

## Dependencies

- `minizip` - ZIP file compression
- `hdf5` - Hierarchical data format
- `boost-uuid` - UUID generation (only boost-uuid component)

## Installation

### From vcpkg-ports overlay

```bash
cd vcpkg-ports
vcpkg install FesapiCpp --overlay-ports=$PWD
```

### Usage in CMake

```cmake
find_package(FesapiCpp CONFIG REQUIRED)
target_link_libraries(your_target PRIVATE FesapiCpp::FesapiCpp)
```

## Port-Specific Notes

### Parallel Build Patch

This port includes `fix-configure-file.patch` which wraps `configure_file()` calls with existence checks. This is necessary because the upstream CMakeLists writes generated files to the source directory, causing issues with vcpkg's parallel Debug/Release builds.

### CMake Config Location

The port manually copies CMake config files from `lib/cmake/FesapiCpp/` to `share/FesapiCpp/` because FESAPI uses a non-standard installation location.

## Building Locally

To test changes to this port:

```bash
cd /path/to/vcpkg-ports
vcpkg install FesapiCpp --overlay-ports=$PWD --recurse
```

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 2.13.0.0 | 2026-01-22 | Initial port creation |

## Known Issues

- Currently tested on `arm64-osx` (macOS ARM64) only
- Windows and Linux support not yet tested

## Upstream

- **Repository**: https://github.com/F2I-Consulting/fesapi
- **Documentation**: https://f2i-consulting.github.io/fesapi/
- **Issues**: https://github.com/F2I-Consulting/fesapi/issues
