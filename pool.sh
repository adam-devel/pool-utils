#!/usr/bin/env bash

# find all non-symlink files, excluding .pool for performance reasons (.pool
# shouldn't contain any symlinks).
declare -a find_command=(
  fd
  --type file
  --hidden
  --no-ignore
  --exclude '.pool'
  --print0
)

link() {
  # hashes the first and last 1000bytes of a file.
  hashsum() {
    local file=$1
    cat <(head --bytes "1000" -- "${file}") <(tail --bytes "1000" -- "${file}") |
      md5sum --binary - |
      cut -d' ' -f1
  }

  local file_path
  local file_hash
  local pool_path

  file_path=$1
  pool_path="$(realpath .pool)"
  file_hash="$(hashsum "${file_path}")"

  ln "$file_path" "${pool_path}/${file_hash}" &&
    ln -sf "${pool_path}/${file_hash}" "${file_path}"

  printf "POOL(%s)\t<=\t%s\n" "${file_hash}" "${file_path}"
}

export -f link
export -f hashsum

"${find_command[@]}" | parallel --null link
