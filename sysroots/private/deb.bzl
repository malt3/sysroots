load(":ecosystems.bzl", "get_ecosystem_packages", "get_ecosystem_symlinks")

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

def _ecosystem_packages(*, distro, architecture, ecosystem):
    return [
        _package(distro = distro, name = name, architecture = architecture)
        for name in get_ecosystem_packages(distro, ecosystem)
    ]

def _ecosystem_symlinks(*, distro, ecosystem):
    return get_ecosystem_symlinks(distro, ecosystem)

deb = struct(
    package = _package,
    base_packages = _base_packages,
    ecosystem_packages = _ecosystem_packages,
    ecosystem_symlinks = _ecosystem_symlinks,
)