" vim: set sw=2:
if exists ('loaded_github')
  finish
endif
let loaded_github = 1

" Github related functions

function! GH_Env()
        exec 'normal A | tee $GITHUB_ENV'
endfunction
command! -bang -nargs=0 GHenv call GH_Env()

function! GH_Out()
        exec 'normal A | tee $GITHUB_OUTPUT'
endfunction
command! -bang -nargs=0 GHout call GH_Out()

command! -bang -nargs=0 GHenvout call GH_Env() | call GH_Out()
