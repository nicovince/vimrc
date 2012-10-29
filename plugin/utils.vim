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
  let l:date = strftime("%a %d %b %Y - %H:%M")
  let l:week = strftime("%W")
  if strftime("%u")>4
    let l:week = l:week + 1
  endif
  exec "normal i".l:week . ") " . l:date . " :                           |     |"
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
function CleanLogFile()
  exe ":%s#[\\d\\+m##g"
endfunction
" alias
command! -bang -nargs=0 CleanLogFile call CleanLogFile()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
