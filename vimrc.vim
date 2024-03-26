" An example for a vimrc file.
"
" Maintainer: Bram Moolenaar <Bram@vim.org>
" Last change:  2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"       for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"     for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? 'evim'
  finish
endif

"-----------------------------------------------------------------------------
" Vim General Config
"-----------------------------------------------------------------------------

" runtimepath is used to get vim configuration files and folders
" default value is to $HOME/.vim which may not work when using
" vim -u /path/to/vimrc
" since i know this file is in my vim folder I can retrieve vim folder
" by getting full path of this file without the filename
let $vimfolder = expand('<sfile>:p:h')
" the ^= assign the variable if the rhs is not already in the lhs
set runtimepath^=$vimfolder

if isdirectory('/usr/share/lilypond/2.18.2/vim/')
  filetype off
  set runtimepath^=/usr/share/lilypond/2.18.2/vim/
  filetype on
  syntax on
endif

if isdirectory('/usr/share/lilypond/2.20.0/vim/')
  filetype off
  set runtimepath^=/usr/share/lilypond/2.20.0/vim/
  filetype on
  syntax on
endif

if isdirectory('/usr/share/lilypond/2.22.1/vim/')
  filetype off
  set runtimepath^=/usr/share/lilypond/2.22.1/vim/
  filetype on
  syntax on
endif

if isdirectory('/usr/share/doc/fzf/examples')
  set runtimepath^=/usr/share/doc/fzf/examples
endif

let $localvimrc = $vimfolder . '/local.vim'
if filereadable($localvimrc)
  source $localvimrc
endif


if has('win32')
  set fileformats=dos,unix
else
  set shell=/bin/bash " Shell to use for external command (:!ls)
endif

"-------------------------------
" User interface configuration
"-------------------------------
set number " display line number
set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P "status bar
set laststatus=2 " Always show status line
set background=dark " My terminal background is dark.

" Lightline configuration, overrides statusline and tabline
let g:lightline = {
  \ 'component_function': {
  \   'gitbranch': 'FugitiveStatusline'
  \ },
  \ }
let g:lightline.component = {
  \ 'charvalhexprefix': '0x%B',
  \ 'lineinfovirt': '%3l:%-2c%2V'}
let g:lightline.tabline = {
  \ 'left': [ [ 'tabs' ] ],
  \ 'right': [ [ 'close' ] ] }
let g:lightline.active = {
  \ 'left': [ [ 'mode', 'paste' ],
  \           [ 'readonly', 'filename', 'modified' ],
  \           [ 'gitbranch'] ],
  \ 'right': [ [ 'lineinfovirt' ],
  \            [ 'percent' ],
  \            [ 'fileformat', 'fileencoding' ] ] }

let g:lightline.inactive = {
  \ 'left': [ [ 'relativepath', 'modified' ] ],
  \ 'right': [ [ 'line' ],
  \            [ 'percent' ] ] }

" Remove toolbar
set guioptions-=T

set showtabline=1 " show tabline only if there are at least two tab
set wildmenu " show menu when pressing TAB in command mode
set wildmode=list:longest " complete with longest common string
set wildignore=*.o,*.obj,*.bak,*.exe,*~ " do not complete with some pattern

set scrolloff=2 " two lines visible above and under cursor
set ruler      " show the cursor position all the time
set showcmd    " display incomplete commands
set history=50 " keep 50 lines of command line history

"---------------------
" Edition options
"---------------------
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" wrap on a word insert of character at the end of a long line
"set lbr
set showmatch " show matching opening parenthesis, curly braces
set expandtab " replace tabulation with spaces
set incsearch  " do incremental searching
set splitright " when splitting the cursor is on the right window



if has('vms')
  set nobackup    " do not keep a backup file, use versions instead
else
  set backup    " keep a backup file
endif

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

"-------------
" Shortcuts
"-------------
" change current directory to current file directory
map !cd :lcd %:p:h<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctags mapping
" jump to tag under cursor
map !z :Tags <C-R><C-W><CR>
" tab window
map !t :tab split <CR> :Tags <C-R><C-W><CR>
" split window
map !s :split <CR> :Tags <C-R><C-W><CR>
" open a preview window and jump to to tag under cursor
map !p :ptjump <C-R><C-W><CR>
" close preview window
map !c :pclose <CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highligh trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
let g:highlight_trailing_ws = 1

" Match all whitespaces at end of line
function MatchTrailingWS()
    if g:highlight_trailing_ws == 1
        match ExtraWhitespace /\s\+$/
    endif
endfunction

" Match whitespaces at end of line except for current line
function MatchTrailingWSExceptCurrent()
    if g:highlight_trailing_ws == 1
        match ExtraWhitespace /\s\+\%#\@<!$/
    endif
endfunction

" Enable highlighting
function EnableHighlightTrailingWS()
    let g:highlight_trailing_ws = 1
    highlight ExtraWhitespace ctermbg=red guibg=red
    call MatchTrailingWS()
endfunction

" Disable highlighting
function DisableHighlightTrailingWS()
    let g:highlight_trailing_ws = 0
    highlight clear ExtraWhitespace
endfunction

call MatchTrailingWS()
" highlight trailing spaces on/off \wn / \wf
nnoremap <Leader>wn :call EnableHighlightTrailingWS()<CR>
nnoremap <Leader>wf :call DisableHighlightTrailingWS()<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" clang-format mappings
map <C-K> :py3file /usr/share/vim/addons/syntax/clang-format.py<cr>
imap <C-K> <c-o>:py3file /usr/share/vim/addons/syntax/clang-format.py<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>


" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has('gui_running')
  syntax on
  set hlsearch
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Saner command line history
" uses ctrl-p and ctrl-n to go up in history by recalling command line whose
" beginning matches the current command line (similar to bash
" history-search-backward/forward)
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbreviation in command mode to replace '%%' with the path of the current
" file
" http://vim.wikia.com/wiki/Easy_edit_of_files_in_the_same_directory
" There is a bug with lilypond syntax script (/usr/share/lilypond/2.18.2/vim/syntax/lilypond.vim)
" where typing %%/ would not perform the abbreviation. It seems to be linked
" with including /usr/share/vim/vim80/syntax/scheme.vim which sets iskeyword
" to a non standard value, which messes up the abbreviation triggers.
" I worked around the issue by restoring iskeyword in my local
" ftplugin/lilypond.vim
cabbr <expr> %% expand('%:h')

cabbr hlep help

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Only do this part when compiled with support for autocommands.
if has('autocmd')

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  "autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " filetype
  autocmd BufNEwFile,BufRead *.overlay setlocal filetype=dts
  autocmd BufNEwFile,BufRead *.lypp setlocal filetype=lilypond
  autocmd BufNEwFile,BufRead *.vh setlocal filetype=verilog
  autocmd BufNEwFile,BufRead SConstruct setlocal filetype=python
  autocmd BufNEwFile,BufRead *.cw setlocal filetype=c
  autocmd BufNEwFile,BufRead *.sv setlocal filetype=verilog
  autocmd BufNEwFile,BufRead *.lte setlocal filetype=xml
  autocmd BufNEwFile,BufRead hg-editor-*.txt setlocal syntax=hgcommit
  autocmd BufNEwFile,BufRead hg-editor.msg setlocal syntax=hgcommit
  autocmd BufRead,BufNewFile iceberg.txt set filetype=icelog
  autocmd Filetype ada setlocal sw=3 expandtab

  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Highlight trailing space, must be set before colorscheme command
  " Based on https://vim.fandom.com/wiki/Highlight_unwanted_spaces
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
  autocmd WinEnter * call MatchTrailingWS()
  autocmd InsertEnter * call MatchTrailingWSExceptCurrent()
  autocmd InsertLeave * call MatchTrailingWS()
  autocmd BufWinLeave * call clearmatches()

  augroup END

else

  set autoindent    " always set autoindenting on

endif " has("autocmd")

colorscheme desert
