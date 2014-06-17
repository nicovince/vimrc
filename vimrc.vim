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
if v:progname =~? "evim"
  finish
endif

if $TERM == 'linux'
  set <F1>=[[A
  set <F2>=[[B
  set <F3>=[[C
  set <F4>=[[D
  set <F5>=[[E
  set <S-F1>=[25~
  set <S-F2>=[26~
  set <S-F3>=[28~
  set <S-F4>=[29~
  set <S-F5>=[31~
  set <S-F6>=[32~
  set <S-F7>=[33~
  set <S-F8>=[34~
  set <S-CR>=OM

  " `Gnome Terminal' fortunately sets $COLORTERM; it needs <BkSpc> and <Del>
  " fixing, and it has a bug which causes spurious "c"s to appear, which can be
  " fixed by unsetting t_RV:
elseif $COLORTERM == 'gnome-terminal'
  "execute 'set t_kb=' . nr2char(8)
  " [Char 8 is <Ctrl>+H.]
  fixdel
  "set t_RV=

  " Gnome-terminal:
  set <S-F1>=OP
  set <S-F2>=OQ
  set <S-F3>=OR
  set <S-F4>=OS
  set <S-F5>=[15~
  set <S-F6>=[17~
  set <S-F7>=[18~
  set <S-F8>=[19~
  set <S-F9>=[20~
  set <S-F10>=[21~
  set <S-F11>=[23~
  set <S-F12>=[24~

  " `XTerm', `Konsole', and `KVT'.
  " there's no easy way of distinguishing these terminals from other things
  " that claim to be "xterm", but `RXVT' sets $COLORTERM to "rxvt" and these
  " don't:
elseif $COLORTERM == ''

  " all also need <BkSpc> and <Del> fixing;
  "execute 'set t_kb=' . nr2char(8)
  "fixdel

  " The above won't work if an `XTerm' or `KVT' is started from within a `Gnome
  " Terminal' or an `RXVT': the $COLORTERM setting will propagate; it's always
  " OK with `Konsole' which explicitly sets $COLORTERM to "".

  " Konsole
  set <S-F1>=O2P
  set <S-F2>=O2Q
  set <S-F3>=O2R
  set <S-F4>=O2S
  set <S-F5>=[15;2~
  set <S-F6>=[17;2~
  set <S-F7>=[18;2~
  set <S-F8>=[19;2~
  set <S-F9>=[20;2~
endif


"-----------------------------------------------------------------------------
" Vim General Config
"-----------------------------------------------------------------------------

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible


" display line number
set number

"status bar
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
"Always show status line
set laststatus=2

"colorscheme for black background :
colorscheme mydarkblue
" fix CursorColumn color group was : "hi CursorColumn term=reverse ctermbg=0 guibg=Grey40
"hi CursorColumn term=reverse cterm=reverse ctermfg=4 ctermbg=7 gui=reverse guifg=#8080ff guibg=fg

" MyTabLine defined in $VIM/plugin/
set tabline=%!MyTabLine()
set guitablabel=%{GuiTabLabel()}
" show tabline only if there are at least two tab
set showtabline=1 " 2=always
"autocmd GUIEnter * hi! TabLineFill term=underline cterm=underline gui=underline
"autocmd GUIEnter * hi! TabLineSel term=bold,reverse,underline ctermfg=11 ctermbg=12 guifg=#ffff00 guibg=#0000ff gui=underline

" Set buffer variable depending on where file is located.
" This is used to set different config for various teams
autocmd! BufReadPre,BufNewFile * call SetupEnv()


" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" wrap on a word insert of character at the end of a long line
"set lbr

" menu appears when tab is pressed while entering a commmand if multiple choices
set wildmenu
set wildmode=list:longest
set wildignore=*.o,*.obj,*.bak,*.exe,*~


if has("vms")
  set nobackup    " do not keep a backup file, use versions instead
else
  set backup    " keep a backup file
endif

set history=50 " keep 50 lines of command line history
set ruler      " show the cursor position all the time
set showcmd    " display incomplete commands
set incsearch  " do incremental searching
set splitright " when splitting the cursor is on the right window

" two lines visible above and under cursor
set scrolloff=2

" when typing a closing accolade, parenthesis or else jump
" to the opening one a few seconds
set showmatch

" replace tabs whith space
set expandtab


" Specify shell used when calling shell (ie : :!ls)
set shell=/bin/bash

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" change current directory to current file directory
map ,cd :lcd %:p:h<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctags mapping
" jump to tag under cursor
map <F2> :tjump <C-R><C-W> <CR>zt
map ,z :tjump <C-R><C-W> <CR>zt
map <S-F2> :tab split <CR> :tjump <C-R><C-W> <CR>zt
map ,t :tab split <CR> :tjump <C-R><C-W> <CR>zt
" open a preview window and jump to to tag under cursor
map <F3> :ptjump <C-R><C-W><CR>
map ,p :ptjump <C-R><C-W><CR>
" split preview window
map <S-F3> :stjump <C-R><C-W><CR>
map ,s :stjump <C-R><C-W><CR>
" close preview window
map <F4> :pclose <CR>
map ,c :pclose <CR>
" unmap operator pending mode
ounmap <F2>
ounmap <F3>
ounmap <F4>


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
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" highligt trailing spaces on/off \wn / \wf
map <Leader>wn <ESC>:highlight WhiteSpaceEol ctermbg=darkgreen guibg=lightgreen<CR><ESC>:match WhiteSpaceEol /\s\+$/<CR>
map <Leader>wf <ESC>:highlight WhiteSpaceEol NONE<CR>
" uncomment the following to enable highlight of trailing whitespaces by default
"autocmd BufAdd,BufRead * highlight WhiteSpaceEol ctermbg=darkgreen guibg=lightgreen
"autocmd BufAdd,BufRead * match WhiteSpaceEol /\s\+$/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbreviation in command mode to replace '%%' with the path of the current
" file
" http://vim.wikia.com/wiki/Easy_edit_of_files_in_the_same_directory
cabbr <expr> %% expand('%:h')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Only do this part when compiled with support for autocommands.
if has("autocmd")

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
  autocmd BufNEwFile,BufRead *.vh setlocal filetype=verilog
  autocmd BufNEwFile,BufRead *.cw setlocal filetype=c
  autocmd BufNEwFile,BufRead *.sv setlocal filetype=verilog
  autocmd BufNEwFile,BufRead *.lte setlocal filetype=xml
  autocmd BufNEwFile,BufRead hg-editor-*.txt setlocal syntax=hgcommit
  autocmd BufNEwFile,BufRead hg-editor.msg setlocal syntax=hgcommit

  augroup END

else

  set autoindent    " always set autoindenting on

endif " has("autocmd")
