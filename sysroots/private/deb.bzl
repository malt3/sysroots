load(":ecosystems.bzl", "PACKAGES", "SYMLINKS")

_BASE_PACKAGES = ["base-files", "libc6", "libc6-dev"]

def _package(*, distro, name, architecture):
    return "@{distro}//{name}/{architecture}".format(
        distro = distro,
        name = name,
        architecture = architecture,
    )

def _base_packages(*, distro, architecture):
    return [
        _package(distro = distro, name = name, architecture = architecture)
        for name in _BASE_PACKAGES
    ]

def _ecosystem_packages(*, distro, architecture, ecosystem, ecosystem_version):
    return [
        _package(distro = distro, name = name, architecture = architecture)
        for name in PACKAGES[ecosystem][ecosystem_version]
    ]

def _ecosystem_symlinks(*, ecosystem, ecosystem_version):
    return SYMLINKS[ecosystem][ecosystem_version]

deb = struct(
    package = _package,
    base_packages = _base_packages,
    ecosystem_packages = _ecosystem_packages,
    ecosystem_symlinks = _ecosystem_symlinks,
)
