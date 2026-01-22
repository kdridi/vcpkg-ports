# vcpkg-ports

Personal [vcpkg](https://github.com/microsoft/vcpkg) overlay ports collection.

This repository contains custom vcpkg ports that are not yet available in the official vcpkg registry or are modified versions for specific needs.

## 🚀 Quick Start

### Install ports using overlay mode

```bash
# Clone this repository
git clone https://github.com/kdridi/vcpkg-ports.git
cd vcpkg-ports

# Install a specific port (example: fesapi)
vcpkg install fesapi --overlay-ports=$PWD
```

### Use in your project

Add to your `CMakeLists.txt`:

```cmake
find_package(PackageName CONFIG REQUIRED)
target_link_libraries(your_target PRIVATE PackageName::PackageName)
```

Configure CMake with vcpkg toolchain:

```bash
cmake -B build -DCMAKE_TOOLCHAIN_FILE=/path/to/vcpkg/scripts/buildsystems/vcpkg.cmake
```

## 📦 Available Ports

| Port | Version | Description |
|------|---------|-------------|
| [fesapi](./fesapi/) | 2.14.0.0 | Energistics data standards support (RESQML, WITSML, PRODML) |

## 📁 Repository Structure

```
vcpkg-ports/
├── README.md              # This file
├── fesapi/                # FESAPI port
│   ├── portfile.cmake
│   ├── vcpkg.json
│   ├── usage
│   ├── patch/
│   └── README.md
└── [other-ports]/         # Future ports
```

## 🔧 How to Use

### Method 1: Command line overlay

```bash
vcpkg install <port-name> --overlay-ports=/path/to/vcpkg-ports
```

### Method 2: Environment variable

```bash
export VCPKG_OVERLAY_PORTS=/path/to/vcpkg-ports
vcpkg install <port-name>
```

### Method 3: Manifest mode (vcpkg.json)

In your project's `vcpkg.json`:

```json
{
  "name": "my-project",
  "version": "1.0.0",
  "dependencies": [
    "fesapi"
  ],
  "overlay-ports": [
    "/path/to/vcpkg-ports"
  ]
}
```

Or use relative paths:

```json
{
  "overlay-ports": [
    "../vcpkg-ports"
  ]
}
```

## 🛠️ Development

### Adding a new port

1. Create a new directory: `ports/<port-name>/`
2. Add required files:
   - `portfile.cmake` - Build instructions
   - `vcpkg.json` - Metadata and dependencies
   - `usage` - Consumer instructions
3. Test locally:
   ```bash
   vcpkg install <port-name> --overlay-ports=$PWD
   ```

### Testing a port

```bash
# Clean install
vcpkg remove <port-name> --recurse
vcpkg install <port-name> --overlay-ports=$PWD

# Test in sample project
mkdir test && cd test
cat > CMakeLists.txt << 'EOF'
cmake_minimum_required(VERSION 3.15)
project(test)
find_package(<PackageName> CONFIG REQUIRED)
message(STATUS "Package found")
EOF
cmake -B build -DCMAKE_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake
```

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork this repository
2. Create a feature branch
3. Add or update ports with proper documentation
4. Test your changes
5. Submit a pull request

### Port Submission Guidelines

Each port should include:
- ✅ Proper `vcpkg.json` with metadata
- ✅ Working `portfile.cmake`
- ✅ `usage` file for consumers
- ✅ README with port-specific documentation
- ✅ Minimal patches (prefer upstream changes)
- ✅ Multi-platform support when possible

## 📚 Resources

- [vcpkg Official Documentation](https://learn.microsoft.com/en-us/vcpkg/)
- [vcpkg Packaging Guide](https://learn.microsoft.com/en-us/vcpkg/contributing/packaging-guide/)
- [vcpkg Overlay Ports](https://learn.microsoft.com/en-us/vcpkg/concepts/overlay-ports)
- [vcpkg Community Discord](https://discord.gg/vcpkg)

## 📝 License

Each port follows the license of its upstream package. See individual port directories for details.

## 🔗 Links

- **Repository**: https://github.com/kdridi/vcpkg-ports
- **Issue Tracker**: https://github.com/kdridi/vcpkg-ports/issues
- **vcpkg Official**: https://github.com/microsoft/vcpkg

---

**Note**: This is a personal overlay collection. Ports here may eventually be submitted to the official vcpkg repository. Use at your own risk.
