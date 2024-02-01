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

if [ $usage = 1 ]; then
  echo "Usage: $0 [cp39|cp310|cp311|cp312]"
  exit 1
fi

bazel \
  test //... \
  --@rules_python//python/config_settings:python_version="$version"
