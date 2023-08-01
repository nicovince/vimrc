" vim: set sw=2:
if exists ('loaded_github')
  finish
endif
let loaded_github = 1

" Github related functions

" Append to current line, command to send stdout to github env file.
" Used to set env variables for next steps and see the value in current step.
function! GH_Env()
        exec 'normal A | tee -a $GITHUB_ENV'
endfunction
command! -bang -nargs=0 GHenv call GH_Env()

" Append to current line command to send stdout to github output
" Used to set output variables for a step and see the value in the logs.
function! GH_Out()
        exec 'normal A | tee -a $GITHUB_OUTPUT'
endfunction
command! -bang -nargs=0 GHout call GH_Out()

command! -bang -nargs=0 GHenvout call GH_Env() | call GH_Out()
