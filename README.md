# bazel-pycross-zstandard-example

This is example of builds the [zstandard](https://pypi.org/project/zstandard/) project cross-python version, cross-os, and cross-machine using the following tools:

* [Bazel](https://bazel.build/)
* [python-build-standalone](https://github.com/indygreg/python-build-standalone) (via [rules_python](https://github.com/bazelbuild/rules_python))
* A derivative of [crossenv](https://github.com/benfogle/crossenv) (via [rules_pycross](https://github.com/jvolkman/rules_pycross))
* [repairwheel](https://github.com/jvolkman/repairwheel) (via rules_pycross)
* [zig cc](https://andrewkelley.me/post/zig-cc-powerful-drop-in-replacement-gcc-clang.html) (via [hermetic_cc_toolchain](https://github.com/uber/hermetic_cc_toolchain))

To use:
* First, install [bazelisk](https://github.com/bazelbuild/bazelisk?tab=readme-ov-file#installation)
* Run tests: `./run_tests.sh cp39` (or `cp310`, `cp311`, `cp312`)
* Build a wheel: `./build_wheel.sh cp39 linux-aarch64` (see usage for other platforms)

Built extensions are dynamically linked to `libzstd` which is vendored in the built wheel after running through `repairwheel`.

Wheel builds are (or at least should be) fully reproducible - even
when built on different build host platforms. I.e., the `macos-aarch64` wheen should have the same sha256 hash whether it was built on macOS or on linux.

**Big caveat:** this only supports linux and macOS, not Windows.
