" vim: set sw=2:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Reverse line order on selection
command! -bar -range=% Reverse <line1>,<line2>g/^/m<line1>-1|nohl

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SVN stuff
function! SvnBlame(...) range
  let l:revision = a:0 >= 1 ? "-r " . a:1 . " " : ""
  " Get file name
  let l:fileName = expand('%:p')
  let cmd="!svn blame " . l:revision . l:fileName . " | sed -n ". a:firstline . "," . a:lastline . "p"
  execute cmd
endfunction

" performs a blame on the selection
vmap gl :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GIT stuff
function! GitBlame(...) range
  let l:revision = a:0 >= 1 ? "-r " . a:1 . " " : ""
  " Save current directory
  let l:cwd = getcwd()
  " Get dirname of current file and cd to it to make sure we are in the valid git repository
  let l:dirName = expand('%:p:h')
  exe "lcd " . l:dirName

  " Get file name
  let l:fileName = expand('%:p')
  " run git blame on file name
  let cmd="!git blame -L" . a:firstline . "," . a:lastline . " " . l:revision . l:fileName
  echo cmd
  execute cmd

  " and go back to saved directory
  exe "lcd " . l:cwd
endfunction
vmap ,g :call GitBlame()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Tab for completion when next to a word otherwise insert tabulation
function! InsertTabWrapper(direction)
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  elseif "backward" == a:direction
    return "\<c-p>"
  else
    return "\<c-n>"
  endif
endfunction

" tab performs word completion
inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>
inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for file with c-style comment, define the regex to colorize comments
" in normal mode do :
" call SetCStyleComment()
function SetCStyleComment()
  syn region  CStyleComment start="/\*" end="\*/"
  syn match   CStyleComment "//.*"
  hi link CStyleComment Comment
endfunction
" alias
command! -bang -nargs=0 SetCStyleComment call SetCStyleComment()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function WeeklyItem()
  " Since my home was moved to aloxe, the hour returned by strftime is off by
  " one
  " Update : The issue has been fixed after my NX session crashed
  let l:hour = strftime("%H")
  "if l:hour <= 9
  "  let l:hour = "0" . l:hour
  "endif
  let l:time = l:hour . ":" . strftime("%M")
  let l:date = strftime("%a %d %b %Y")
  let l:week = strftime("%V")
  " new week starts on friday
  if strftime("%u")>4
    let l:week = l:week + 1
    if l:week<10
      let l:week = "0" . l:week
    endif
    exec "normal Go"
    exec "normal o-----------------------------------------------------------------------------------------------------------------------"
  endif
  exec "normal Go".l:week . ") " . l:date . " - " . l:time . " :                           |     |"
endfunction
" alias
command! -bang -nargs=0 WeeklyItem call WeeklyItem()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function MatchEol()
  bufdo highlight WhiteSpaceEol ctermbg=darkgreen guibg=lightgreen | match WhiteSpaceEol /\s\+$/
endfunction
" alias
command! -bang -nargs=0 MatchEol call MatchEol()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Look in parent folders for a tag file
function SetTagsFile()
  " Your customised tags go first.
  "set tags+=~/tags,$DOC/tags
  let parent_dir = expand("%:p:h")."/"
  while match(parent_dir,"/",0)>-1 && isdirectory(parent_dir)
    let parent_tag = parent_dir."tags"
    if filereadable(parent_tag)
      exe ":set tags+=".parent_tag
    endif
    let parent_dir = substitute(parent_dir,"[^/]*/$","","")
  endwhile
  let parent_dir = getcwd()."/"
  while match(parent_dir,"/",0)>-1 && isdirectory(parent_dir)
    let parent_tag = parent_dir."tags"
    if filereadable(parent_tag)
      exe ":set tags+=".parent_tag
    endif
    let parent_dir = substitute(parent_dir,"[^/]*/$","","")
  endwhile
  unlet parent_dir parent_tag
endfunction
" alias
command! -bang -nargs=0 SetTagsFile call SetTagsFile()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" remove shell colors from log file
function CleanLogFile()
  exe ":%s#[\\d\\+m##g"
endfunction
" alias
command! -bang -nargs=0 CleanLogFile call CleanLogFile()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set file as read-only and make file impossible to modify
function DontTouch()
  set nomodifiable
  set readonly
endfunction
" alias
command -bang -nargs=0 DontTouch call DontTouch()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Converts file format to/from unix
command Unixformat :set ff=unix
command Dosformat :set ff=dos

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search pattern in the current verilog module
function SearchInCurrentModule(search_pattern)
  " Replace search pattern with current word under cursor if search pattern
  " is empty
  let l:search_pattern = a:search_pattern
  if strlen(l:search_pattern) == 0
    let l:search_pattern = "\\<" . expand("<cword>") . "\\>"
  endif

  " save current cursor position
  let l:save_cursor = getpos(".")
  let l:endmodule_line = searchpair('^\s*module','','^\s*endmodule','')
  let l:module_line =    searchpair('^\s*module','','^\s*endmodule','bW')
  let l:search_cmd = '\%>' . l:module_line . 'l\%<' . l:endmodule_line . 'l' . l:search_pattern
  " set the search in the search register
  let @/ = l:search_cmd
  " restore cursor position
  call setpos('.', save_cursor)
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! KprimeLprimeNs(idx, kp, lp, ns)
  let l:kp = a:kp
  if strlen(l:kp) == 1
    let l:kp = " " . l:kp
  endif

  let l:idx = a:idx
  if strlen(l:idx) == 1
    let l:idx = " " . l:idx
  endif

  let l:entry = "KprimeLprimeNsMod2_t(" . l:kp . ", " . a:lp . ", " . a:ns . "), // " . l:idx
  exec "normal o".l:entry
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set b:envPi if path of current filename match work/PI
function! SetupEnv()
  let l:path = expand('%:p')
  if l:path =~ 'work/PI'
    let b:envPi = 1
  endif
endfunction
