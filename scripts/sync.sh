#!/bin/sh
# Copies core/ files into each skill's references/ so every skill installs standalone.
set -eu
cd "$(dirname "$0")/.."

sync() {
  dest=skills/$1/references
  shift
  rm -rf "$dest"
  mkdir -p "$dest"
  for f; do cp "core/$f.md" "$dest/"; done
}

design="sizing research panel persona-ceo persona-cto persona-designer persona-brand persona-sdet docs stack"

sync design-with-me $design
sync build-with-me $design build-loop debug-loop persona-reviewer
sync debug-with-me debug-loop persona-sdet persona-reviewer
