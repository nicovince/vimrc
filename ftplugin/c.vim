" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
        finish
endif
let b:did_ftplugin = 1

setlocal et
setlocal shiftwidth=4
" Sequans PI config :
if (IsLinux() || IsLinuxDrivers() || IsLibOpenCm3())
        setlocal shiftwidth=8
        setlocal tabstop=8
        setlocal noexpandtab
elseif (IsSiemaInno())
        setlocal expandtab
        setlocal shiftwidth=4
        setlocal tabstop=4
elseif (IsSiema())
        setlocal expandtab
        setlocal shiftwidth=4
        setlocal tabstop=4
endif

function! CaUComment()
        s#^//#////#e
        s#^\([^/]\)#//\1#e
        s#^////##e
endfunction

nnoremap <F12> :call CaUComment()<CR>
inoremap <F12> :call CaUComment()<CR>
vnoremap <F12> :call CaUComment()<CR>

function! CHdrGuard()
        let l:filename = expand("%:t")
        let l:guard = "__" . substitute(toupper(l:filename), "\\.", "_", "g") . "__"
        let l:guard = substitute(l:guard, "-", "_", "g")
        exec "normal ggO#ifndef " . l:guard
        exec "normal o#define " . l:guard
        exec "normal Go#endif /* " . l:guard . " */"
        exec "normal O"
endfunction
command! -bang -nargs=0 CHdrGuard call CHdrGuard()


""""""""""""""""""""""""""
" ENV indentation style
""""""""""""""""""""""""""
" indent argument split on multiple lines aligned on the first arg
" func(arg1,
"      arg2);
setlocal cinoptions+=(0

" indent switch case statement like this :
" switch(x)
" {
" case 1:
"   foo();
" default:
" }
setlocal cinoptions+=:0

