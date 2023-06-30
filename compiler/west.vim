if exists('current_compiler')
  finish
endif
let current_compiler = 'west'
if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif
CompilerSet makeprg=west
CompilerSet errorformat&
