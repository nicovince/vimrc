" Vim script to work like "less"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2006 May 07

" Avoid loading this file twice, allow the user to define his own script.
if exists("loaded_less")
  finish
endif
let loaded_less = 1

" If not reading from stdin, skip files that can't be read.
" Exit if there is no file at all.
if argc() > 0
  let s:i = 0
  while 1
    if filereadable(argv(s:i))
      if s:i != 0
	sleep 3
      endif
      break
    endif
    if isdirectory(argv(s:i))
      echomsg "Skipping directory " . argv(s:i)
    elseif getftime(argv(s:i)) < 0
      echomsg "Skipping non-existing file " . argv(s:i)
    else
      echomsg "Skipping unreadable file " . argv(s:i)
    endif
    echo "\n"
    let s:i = s:i + 1
    if s:i == argc()
      quit
    endif
    next
  endwhile
endif

set nocp
syntax on
set so=999
set hlsearch
set incsearch
set noswapfile
nohlsearch
" Don't remember file names and positions
set viminfo=
"set nows
" Inhibit screen updates while searching
let s:lz = &lz
set lz

" Used after each command: put cursor at end and display position
if &wrap
  noremap <SID>L L0:redraw<CR>:file<CR>
  au VimEnter * normal! L0
else
  noremap <SID>L Lg0:redraw<CR>:file<CR>
  au VimEnter * normal! Lg0
endif

" When reading from stdin don't consider the file modified.
au VimEnter * set nomod

" Can't modify the text
set noma


" Scroll one page forward
noremap <script> <Space> :call <SID>NextPage()<CR><SID>L
fun! s:NextPage()
  if line(".") == line("$")
    if argidx() + 1 >= argc()
      quit
    endif
    next
    1
  else
    exe "normal! \<C-F>"
  endif
endfun

" Quitting
noremap q :q<CR>

" Switch to editing (switch off less mode)
map v :silent call <SID>End()<CR>
fun! s:End()
  set ma
  if exists('s:lz')
    let &lz = s:lz
  endif
  unmap <Space>
  unmap q
  unmap v
endfun

" vim: sw=2
