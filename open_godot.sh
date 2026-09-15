#!/bin/sh
# Exit immediately if a command exits with a non-zero status
set -e


if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  export HOST_OS=Linux
elif [[ "$OSTYPE" == "darwin"* ]]; then
  export HOST_OS=macOS
elif [[ "$OSTYPE" == "cygwin" ]]; then
  export HOST_OS=Linux
elif [[ "$OSTYPE" == "msys" ]]; then
  export HOST_OS=Windows
elif [[ "$OSTYPE" == "win32" ]]; then
  # I'm not sure this can happen.
  export HOST_OS=Windows
elif [[ "$OSTYPE" == "freebsd"* ]]; then
  export HOST_OS=Linux
else
  export HOST_OS=NOT_SET
fi

GODOT_VER="4.7.2-stable"

case $HOST_OS in
  "Linux")
    GODOT_EDITOR_EXE="Godot_v${GODOT_VER}_linux.x86_64"
    ;;
  "macOS")
    ;;
  "Windows")
    GODOT_EDITOR_EXE="Godot_v${GODOT_VER}_win64.exe"
    ;;
  *)
    ;;
esac

PATH_GODOT_EDITOR_EXE=".editor/${GODOT_EDITOR_EXE}"

die() {
  printf '%s\n' "$1" >&2
  exit 1
}

make_dir() {
  mkdir -p $1
  printf "Made dir $1\n"
}

rm_file() {
  rm -f $1
  printf "Removed file $1\n"
}

download_editor() {
  make_dir ".editor"

  printf "Download Godot editor ${GODOT_VER}\n"
  zip_file="${GODOT_EDITOR_EXE}.zip"
#https://github.com/godotengine/godot/releases/download/4.7.2-stable/Godot_v4.7.2-stable_linux.x86_64.zip
  url="https://github.com/godotengine/godot/releases/download/${GODOT_VER}/${zip_file}"
  downloaded_file=".editor/${zip_file}"

  printf "  zip file:\t${zip_file}\n"
  printf "  url:\t\t${url}\n"
  printf "  download to:\t${downloaded_file}\n\n"

  # Check if Godot editor has been installed, if not install it
  if [ -f "${PATH_GODOT_EDITOR_EXE}" ]; then
    printf "  No need to download ${GODOT_EDITOR_EXE}, it is already installed\n"
  else

    # delete the downloaded file if it exists
    if [ -f "${downloaded_file}" ]; then
      rm_file "${downloaded_file}"
    fi

    # download and extract the godot editor to the godot-editor folder
    if curl -L# -o "${downloaded_file}" "${url}"; then
      printf "Downloaded ${url}\n"
      unzip "${downloaded_file}" -d .editor
      printf "Extracted ${zip_file} into .editor\n"
    else
      die "Cannot download ${url}\n\n"
    fi
  fi
  printf "\n"
}

download_editor
"${PATH_GODOT_EDITOR_EXE}" -e --path ./godot-project
