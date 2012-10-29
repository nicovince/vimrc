" Vim color file
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2001 Jul 23

" This is the default color scheme.  It doesn't define the Normal
" highlighting, it uses whatever the colors used to be.

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
"
" Default Light Blue
" adjusted to get a better blue with dark background
hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let colors_name = "defaultLB"
hi TabLine term=underline cterm=underline ctermfg=0 ctermbg=7 gui=underline guibg=LightGrey
hi TabLineFill term=reverse cterm=reverse gui=reverse
hi TabLineSel term=bold cterm=bold gui=bold
hi SpecialKey term=bold cterm=bold ctermfg=DarkBlue gui=bold guifg=DarkBlue
hi LineNr term=underline ctermfg=DarkYellow guifg=DarkYellow
hi CursorColumn term=reverse ctermbg=7 guibg=Grey90
hi CursorLine term=underline cterm=underline guibg=Grey90



"hi StatusLine term=bold,reverse cterm=bold,reverse gui=bold guifg=White guibg=Black
"hi StatusLineNC term=reverse cterm=reverse gui=bold guifg=PeachPuff guibg=Gray45

" Colors for syntax highlighting
"hi Comment    cterm=bold ctermfg=Blue     gui=NONE guifg=Blue
hi Directory    cterm=bold ctermfg=Blue     gui=NONE guifg=Blue
hi Comment    cterm=bold ctermfg=Blue     gui=NONE guifg=Blue
hi Identifier term=underline ctermfg=6 guifg=DarkCyan
hi Statement term=bold ctermfg=3 gui=bold guifg=Brown
hi PreProc term=underline ctermfg=5 guifg=Magenta3
hi Type term=underline ctermfg=2 gui=bold guifg=SeaGreen
"hi Ignore cterm=bold ctermfg=7 guifg=bg
"hi Error term=reverse cterm=bold ctermfg=7 ctermbg=1 gui=bold guifg=White guibg=Red
"hi Todo term=standout ctermfg=0 ctermbg=3 guifg=Blue guibg=Yellow
"hi Comment term=bold ctermfg=4 guifg=#406090
"hi Constant term=underline ctermfg=1 guifg=#c00058
hi Special term=bold ctermfg=5 guifg=SlateBlue


" vim: sw=2
