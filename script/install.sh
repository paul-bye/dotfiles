#!/usr/bin/env bash
#
# installs everything.
set -e

DOTFILES_ROOT=$(pwd -P)

link_file () {
  local src=$1 dst=$2

  if [[ (-f "$dst") || (-d "$dst") || (-L "$dst") ]]
  then
    mv "$dst" "${dst}.backup"
    echo "moved $dst to ${dst}.backup"
  fi

  ln -s "$src" "$dst"
  echo "linked $src to $dst"
}

while IFS= read -r -d '' file
do
  echo file
  dst="$HOME/.$(basename "${file%.*}")"
  link_file "$file" "$dst"
done <   <(find -H "$DOTFILES_ROOT" -name '*.symlink' -not -path '*.git*' -print0)
