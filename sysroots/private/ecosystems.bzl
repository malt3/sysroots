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

_GCC_SYMLINK_TEMPLATES = {
    # Symlink GCC arch-specific headers to where clang expects them
    "usr/include/c++/{version}/x86_64-unknown-linux-gnu": "/usr/include/x86_64-linux-gnu/c++/{version}",
    "usr/include/c++/{version}/aarch64-unknown-linux-gnu": "/usr/include/aarch64-linux-gnu/c++/{version}",
    # Symlink GCC runtime files for x86_64
    "usr/lib/x86_64-linux-gnu/crtbegin.o": "/usr/lib/gcc/x86_64-linux-gnu/{version}/crtbegin.o",
    "usr/lib/x86_64-linux-gnu/crtbeginS.o": "/usr/lib/gcc/x86_64-linux-gnu/{version}/crtbeginS.o",
    "usr/lib/x86_64-linux-gnu/crtbeginT.o": "/usr/lib/gcc/x86_64-linux-gnu/{version}/crtbeginT.o",
    "usr/lib/x86_64-linux-gnu/crtend.o": "/usr/lib/gcc/x86_64-linux-gnu/{version}/crtend.o",
    "usr/lib/x86_64-linux-gnu/crtendS.o": "/usr/lib/gcc/x86_64-linux-gnu/{version}/crtendS.o",
    "usr/lib/x86_64-linux-gnu/libgcc.a": "/usr/lib/gcc/x86_64-linux-gnu/{version}/libgcc.a",
    "usr/lib/x86_64-linux-gnu/libgcc_eh.a": "/usr/lib/gcc/x86_64-linux-gnu/{version}/libgcc_eh.a",
    "usr/lib/x86_64-linux-gnu/libstdc++.a": "/usr/lib/gcc/x86_64-linux-gnu/{version}/libstdc++.a",
    # Symlink GCC runtime files for aarch64  
    "usr/lib/aarch64-linux-gnu/crtbegin.o": "/usr/lib/gcc/aarch64-linux-gnu/{version}/crtbegin.o",
    "usr/lib/aarch64-linux-gnu/crtbeginS.o": "/usr/lib/gcc/aarch64-linux-gnu/{version}/crtbeginS.o", 
    "usr/lib/aarch64-linux-gnu/crtbeginT.o": "/usr/lib/gcc/aarch64-linux-gnu/{version}/crtbeginT.o",
    "usr/lib/aarch64-linux-gnu/crtend.o": "/usr/lib/gcc/aarch64-linux-gnu/{version}/crtend.o",
    "usr/lib/aarch64-linux-gnu/crtendS.o": "/usr/lib/gcc/aarch64-linux-gnu/{version}/crtendS.o",
    "usr/lib/aarch64-linux-gnu/libgcc.a": "/usr/lib/gcc/aarch64-linux-gnu/{version}/libgcc.a",
    "usr/lib/aarch64-linux-gnu/libgcc_eh.a": "/usr/lib/gcc/aarch64-linux-gnu/{version}/libgcc_eh.a",
    "usr/lib/aarch64-linux-gnu/libstdc++.a": "/usr/lib/gcc/aarch64-linux-gnu/{version}/libstdc++.a",
}

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