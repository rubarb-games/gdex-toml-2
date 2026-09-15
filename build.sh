#!/bin/sh
# Exit immediately if a command exits with a non-zero status
set -e

mode=$1

if [[ -z "$mode" ]]; then
	mode="debug"
fi

echo "Build ${mode}"

# Clear output dir
rm -rf "./output"
# Run SCons
scons --mode debug .

echo "Install to Godot project"
cp ./output/* ./godot-project/addons/gdex-toml-2/bin/
