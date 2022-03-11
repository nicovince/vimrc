" Vim syntax file
" Language:	reg
" Maintainer:	Nicolas Vincent <nicolas.vincent@zoran.com>

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if v:version < 600
  syntax clear
elseif exists('b:current_syntax')
  finish
endif

syn match   regComment          "#.*$"
syn match   regComment          "--.*$"
syn match   regTrash            "[^#]*$" contained
syn match   regDataNumber	"[0-9a-fA-F]\{8\}" skipwhite nextgroup=regTrash contained
syn match   regAddrNumber	"[0-9a-fA-F]\{8\}" skipwhite nextgroup=regDataNumber skipwhite contained
syn keyword regStatement        WR RM RP W TS R RC T SP nextgroup=regAddrNumber skipwhite nextgroup=regDataNumber skipwhite nextgroup=regTrash
syn match   regPrint            "[a-zA-Z0-9]*" contained
syn keyword regPrintStatement   P skipwhite nextgroup=regPrint skipwhite


if v:version >= 508 || !exists('did_reg_syntax_inits')
  if v:version < 508
    let did_reg_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink regComment              Comment
  HiLink regTrash                Comment
  HiLink regStatement            Type
  HiLink regPrintStatement       Type
  HiLink regAddrNumber           keyword
  HiLink regDataNumber           Identifier
  HiLink regPrint                String

 delcommand HiLink
endif

let b:current_syntax = 'reg'
