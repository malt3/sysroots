GCC = "libstdcxx"
LLVM = "libcxx"

_GCC_PACKAGE_TEMPLATES = [
    "gcc-{version}-base",
    "libgomp1",
    "libstdc++6",
    "libstdc++-{version}-dev",
    "libgcc-{version}-dev",
]

_LLVM_PACKAGE_TEMPLATES = [
    "libclang-rt-{version}-dev",
    "libgcc-12-dev",
    "libc++-{version}-dev",
    "libc++abi-{version}-dev",
]

_LLVM_PACKAGE_TEMPLATES_PLUCKY = [
    "libclang-rt-{version}-dev",
    "libgcc-14-dev",
    "libc++-{version}-dev",
    "libc++abi-{version}-dev",
]

_GCC_SYMLINK_TEMPLATES = {}

_LLVM_SYMLINK_TEMPLATES = {
    "usr/lib/libc++abi.a": "/usr/lib/llvm-{version}/lib/libc++abi.a",
}

ECOSYSTEMS = [GCC, LLVM]

# Per-distro ecosystem versions
ECOSYSTEM_VERSIONS_PER_DISTRO = {
    "bookworm": {
        GCC: 12,
        LLVM: 19,
    },
    "plucky": {
        GCC: 14,
        LLVM: 20,
    },
}

def get_ecosystem_version(distro, ecosystem):
    """Get the ecosystem version for a given distro"""
    return ECOSYSTEM_VERSIONS_PER_DISTRO[distro][ecosystem]

def get_ecosystem_packages(distro, ecosystem):
    """Get the packages for a given distro and ecosystem"""
    version = get_ecosystem_version(distro, ecosystem)
    
    if ecosystem == GCC:
        templates = _GCC_PACKAGE_TEMPLATES
    elif ecosystem == LLVM:
        # Use different templates for plucky (Ubuntu) due to different gcc version
        templates = _LLVM_PACKAGE_TEMPLATES_PLUCKY if distro == "plucky" else _LLVM_PACKAGE_TEMPLATES
    
    return [template.format(version = version) for template in templates]

def get_ecosystem_symlinks(distro, ecosystem):
    """Get the symlinks for a given distro and ecosystem"""
    version = get_ecosystem_version(distro, ecosystem)
    
    if ecosystem == GCC:
        templates = _GCC_SYMLINK_TEMPLATES
    elif ecosystem == LLVM:
        templates = _LLVM_SYMLINK_TEMPLATES
    
    return {linkname.format(version = version): target.format(version = version) for (linkname, target) in templates.items()}