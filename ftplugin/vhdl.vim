" Only do this when not done yet for this buffer
if exists('b:did_ftplugin')
	finish
endif
let b:did_ftplugin = 1
setlocal shiftwidth=2
setlocal et
call SetTagsFile()
setlocal textwidth=0

let g:vhdl_indent_genportmap = 0

" ---------------------------------------------------------------------
" AlignVhdlEntity:
fun! AlignVhdlEntity() range
  " Align :
  call Align#AlignCtrl('p1P1')
  " Ignore comments line
  call Align#AlignCtrl("v ^\\s*--")
  let cmd=a:firstline . ',' . a:lastline . "call Align#Align(0,\":= :\")"
  execute cmd

  " Align comments
  let cmd=a:firstline . ',' . a:lastline . "call Align#Align(0,\"--\")"
  execute cmd

endfun

" ---------------------------------------------------------------------

com! -bang -range -nargs=0 AlignVhdlEntity <line1>,<line2>call AlignVhdlEntity()
" vim: set et sw=2:
