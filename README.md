# C++ sysroot builder

This repository contains Bazel rules that leverage [rules_distroless][rules_distroless] to build tiny sysroot tar files for a matrix of target platforms:

## Distribution

Currently, only a single distribution is supported as a source of packages.
In practice, the choice of distro doesn't matter, but the code allows you to add more distros easily.

- Debian 12 (bookworm)

## Architectures

- amd64
- arm64

## C++ standard libraries

- libstdc++ (GNU)
- libc++ (LLVM)


## Obtaining a sysroot

There are multiple ways for obtaining sysroots:

1. Build the target of choice and put it into a cloud storage bucket


	```
	$ bazel build @sysroots//:sysroot_bookworm_libcxx_amd64
	  bazel-bin/sysroot_bookworm_libcxx_amd64.tar.zst
	```

2. Download the container image and use docker export

	```
	$ crane export --platform=linux/amd64 ghcr.io/malt3/sysroots/libcxx:bookworm ./sysroot.tar
	```
3. Directly download an image layer as an http_archive in Bazel. For this, have a look at the [example][example]

## Using this sysroot in Bazel

I recommend [toolchains_llvm][toolchains_llvm] and [static-clang][static-clang].
The [example][example] shows a way to set this up with the ability to target different C++ standard library implementations.

[rules_distroless]: https://github.com/GoogleContainerTools/rules_distroless
[example]: /example
[toolchains_llvm]: https://github.com/bazel-contrib/toolchains_llvm
[static-clang]: https://github.com/dzbarsky/static-clang
