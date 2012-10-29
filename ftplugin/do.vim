" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1
setlocal shiftwidth=2
setlocal ai
setlocal et

function! CaUComment()
	s/^#/##/e
	s/^\([^#]\)/#\1/e
	s/^##//e
endfunction


nnoremap <F12> :call CaUComment()<CR>
inoremap <F12> :call CaUComment()<CR>
vnoremap <F12> :call CaUComment()<CR>


