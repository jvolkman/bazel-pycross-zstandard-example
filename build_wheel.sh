#!/bin/sh

set -e

usage=0

case $1 in
  cp39)
    version="3.9.18"
    ;;
  cp310)
    version="3.10.13"
    ;;
  cp311)
    version="3.11.6"
    ;;
  cp312)
    version="3.12.0"
    ;;
  *)
    usage=1
    ;;
esac

case $2 in
  linux-amd64)
    platform=linux_x86_64
    ;;
  linux-aarch64)
    platform=linux_aarch64
    ;;
  macos-amd64)
    platform=macos_x86_64
    ;;
  macos-aarch64)
    platform=macos_aarch64
    ;;
  *)
    usage=1
    ;;
esac

if [ $usage = 1 ]; then
  echo "Usage: $0 [cp39|cp310|cp311|cp312] [linux-amd64|linux-aarch64|macos-amd64|macos-aarch64]"
  exit 1
fi

bazel \
  build @pdm//zstandard:wheel \
  --platforms="@zig_sdk//platform:$platform" \
  --@rules_python//python/config_settings:python_version="$version" \
  --output_groups=all_files

mkdir -p wheels
dest="wheels/$(cat bazel-bin/zstandard_build/zstandard-0.22.0.whl.name)"
cp bazel-bin/zstandard_build/zstandard-0.22.0.whl $dest
chmod 644 $dest

echo "Built $dest"
