#!/usr/bin/env bash

unsymlink() {
  local symlink=$1
  local linkpath
  linkpath="$(readlink "${symlink}")"

  ln -f "$linkpath" "${symlink}"
  printf "%s <==> %s\n" "${linkpath}" "${symlink}"
}

# find all symlink files, excluding .pool for performance reasons (.pool
# shouldn't contain any symlinks).
declare -a find_command=(
  fd
  --type symlink
  --hidden
  --no-ignore
  --exclude '.pool'
  --print0
)

export -f unsymlink

"${find_command[@]}" | parallel --null unsymlink

#ln "${files[@]}" .pool/
