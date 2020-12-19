" Only do this when not done yet for this buffer
if exists("b:did_ftplugin_ly")
	finish
endif
let b:did_ftplugin_ly = 1

setlocal iskeyword=@,48-57,_,192-255,#

function! TwoVoices()
        exec "normal o<<"
        exec "normal o{}"
        exec "normal o\\\\"
        exec "normal o{}"
        exec "normal o>> |"
        exec "normal kkk"
endfunction
command -bang -nargs=0 TwoVoices call TwoVoices()
