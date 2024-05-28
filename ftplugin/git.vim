" Only do this when not done yet for this buffer
if exists('b:did_ft_git')
	finish
endif
let b:did_ft_git = 1
" vim: set et sw=2:

function! NoComment()
  exec 'normal o<no_comment></>'
endfunction
com! -bang -nargs=0 NoComment call NoComment()

function! Bugz()
  exec 'normal o<bug id= status= > </>'
endfunction
com! -bang -nargs=0 Bugz call Bugz()
