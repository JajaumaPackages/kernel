#!/bin/bash

if [[ -z $@ ]]; then
    echo "Usage: $0 <kernel-source-tarball> <old-config>" >&2
    exit 1
fi

set -e
newKernelTarball=$1
oldConfig=$2

tmpDir=$(mktemp -d)
tar -xf "$newKernelTarball" -C "$tmpDir"

newKernelTree=("$tmpDir/linux-"*)
cp -f "$oldConfig" "$newKernelTree/.config"
make -sC "$newKernelTree" olddefconfig
cat "$newKernelTree/.config"
