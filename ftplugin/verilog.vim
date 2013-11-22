" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

setlocal shiftwidth=2
setlocal expandtab
setlocal textwidth=0
call SetTagsFile()

function! CaUComment()
        s#^//#////#e
        s#^\([^/]\)#//\1#e
        s#^////##e
endfunction

nnoremap <F12> :call CaUComment()<CR>
inoremap <F12> :call CaUComment()<CR>
vnoremap <F12> :call CaUComment()<CR>

" ---------------------------------------------------------------------
"  matchit
" Set 'cpoptions' to allow line continuations
let s:cpo_save = &cpo
set cpo&vim

" Undo the plugin effect
let b:undo_ftplugin = "setlocal fo< com< tw<"
    \ . "| unlet! b:browsefilter b:match_ignorecase b:match_words"

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal fo-=t fo+=croqlm1

" Set 'comments' to format dashed lists in comments.
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://

" Format comments to be up to 78 characters long
if &textwidth == 0 
  setlocal tw=78
endif

" Win32 can filter files in the browse dialog
if has("gui_win32") && !exists("b:browsefilter")
  let b:browsefilter = "Verilog Source Files (*.v)\t*.v\n" .
        \ "All Files (*.*)\t*.*\n"
endif

" Let the matchit plugin know what items can be matched.
if exists("loaded_matchit")
  let b:match_ignorecase=0
  let b:match_words=
    \ '\<begin\>:\<end\>,' .
    \ '\<generate\>:\<endgenerate\>,' .
    \ '\<case\>\|\<casex\>\|\<casez\>:\<endcase\>,' .
    \ '\<module\>:\<endmodule\>,' .
    \ '\<if\>:\<else\>,' .
    \ '\<function\>:\<endfunction\>,' .
    \ '`ifn\?def\>:`else\>:`endif\>,' .
    \ '\<task\>:\<endtask\>,' .
    \ '\<specify\>:\<endspecify\>'
endif

" Reset 'cpoptions' back to the user's setting
let &cpo = s:cpo_save
" ---------------------------------------------------------------------


" ---------------------------------------------------------------------
function! VerilogHeader()
  let l:year = strftime("%Y")
  let l:license =             "/*****************************************************************************\<enter>"
  let l:license = l:license . " *        This program is the Confidential and Proprietary product of        *\<enter>"
  let l:license = l:license . " *                          'SEQUANS COMMUNICATIONS'                         *\<enter>"
  let l:license = l:license . " *      Any unauthorized use, reproduction or transfer of this program       *\<enter>"
  let l:license = l:license . " *                           is strictly prohibited.                         *\<enter>"
  let l:license = l:license . " *     Copyright(c) " . l:year . " by Sequans Communications. All Rights Reserved.     *\<enter>"
  let l:license = l:license . " *****************************************************************************\<enter>"
  let l:endHeader =           " ****************************************************************************/"

  " Get file name
  let l:fileName = expand('%:t')
  " Get date
  let l:date = strftime("%d %B %Y")

  set paste
  
  exec "normal ggO".l:license
  exec "normal o File        : ".l:fileName
  exec "normal o Author      : Nicolas Vincent"
  exec "normal o Creation    : ".l:date
  exec "normal o"
  exec "normal o Description : "
  exec "normal o".l:endHeader
  set nopaste
endfunction
com! -bang -nargs=0 VerilogHeader call VerilogHeader()

" ---------------------------------------------------------------------
" AlignVerilogModule:
fun! AlignVerilogModule() range
  call Align#AlignCtrl("p1P1")
  " Ignore comments line
  call Align#AlignCtrl("v ^\\s*//")

  " Align comments
  let cmd=a:firstline . "," . a:lastline . "call Align#Align(0,\"//\")"
  execute cmd
endfun
com! -bang -range -nargs=0 AlignVerilogModule <line1>,<line2>call AlignVerilogModule()
" ---------------------------------------------------------------------
function! AlignVerilogInstance() range
  call Align#AlignCtrl("p1P0")
  " Ignore comments line
  call Align#AlignCtrl("v ^\\s*//")

  let cmd=a:firstline . "," . a:lastline . "call Align#Align(0,\"(\")"
  execute cmd
endfunction

" vim: set et sw=2:
