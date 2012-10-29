#!/bin/sh
# Shell script to start Vim with less.vim.
# Read stdin if no arguments were given.

if test $# = 0; then
  gvim --cmd 'let no_plugin_maps = 1' -c 'runtime! macros/less.vim' -
else
  gvim --cmd 'let no_plugin_maps = 1' -c 'runtime! macros/less.vim' "$@"
fi
