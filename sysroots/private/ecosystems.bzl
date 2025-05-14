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

_GCC_SYMLINK_TEMPLATES = {}

_LLVM_SYMLINK_TEMPLATES = {
    "usr/lib/libc++abi.a": "/usr/lib/llvm-{version}/lib/libc++abi.a",
}

ECOSYSTEMS = [GCC, LLVM]
ECOSYSTEM_VERSIONS = {
    GCC: [12],
    LLVM: [19],
}
PACKAGES = {
    GCC: {
        v: [template.format(version = v) for template in _GCC_PACKAGE_TEMPLATES]
        for v in ECOSYSTEM_VERSIONS[GCC]
    },
    LLVM: {
        v: [template.format(version = v) for template in _LLVM_PACKAGE_TEMPLATES]
        for v in ECOSYSTEM_VERSIONS[LLVM]
    },
}
SYMLINKS = {
    GCC: {
        v: {linkname.format(version = v): target.format(version = v) for (linkname, target) in _GCC_SYMLINK_TEMPLATES.items()}
        for v in ECOSYSTEM_VERSIONS[GCC]
    },
    LLVM: {
        v: {linkname.format(version = v): target.format(version = v) for (linkname, target) in _LLVM_SYMLINK_TEMPLATES.items()}
        for v in ECOSYSTEM_VERSIONS[LLVM]
    },
}
