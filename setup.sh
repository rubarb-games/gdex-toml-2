#!/bin/sh
# Exit immediately if a command exits with a non-zero status
set -e

die() {
  printf '%s\n' "$1" >&2
  exit 1
}

# Clone godot-cpp
# if folder exists
if [ -d ./godot-cpp ]; then
	echo "pull"
	git -C ./godot-cpp reset --hard
	git -C ./godot-cpp pull origin 4.5
else
	echo "clone"
	mkdir -p ./godot-cpp
	git clone -b 4.5 --single-branch https://github.com/godotengine/godot-cpp.git ./godot-cpp
fi
