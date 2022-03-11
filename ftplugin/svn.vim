" Only do this when not done yet for this buffer
if exists('b:did_ftplugin')
	finish
endif
let b:did_ftplugin = 1

function! NoComment()
  exec 'normal ggO<no_comment></>'
endfunction
com! -bang -nargs=0 NoComment call NoComment()


function! Svn_diff_windows()
    let i = 0
    let list_of_files = ''

    while i <= line('$')
        let line = getline(i)
        if line =~# '^M'

            let file = substitute(line, '\v^MM?\s*(.*)\s*$', '\1', '')
            let list_of_files = list_of_files . ' '.file
        endif

        let i = i + 1
    endwhile

    if list_of_files == ''
        return 
    endif
    
    new
    silent! setlocal ft=diff previewwindow bufhidden=delete nobackup noswf nobuflisted nowrap buftype=nofile
    exe 'normal :r!LANG=C svn diff ' . list_of_files . "\n"
    setlocal nomodifiable
    goto 1
    redraw!
    wincmd R
    wincmd p
    goto 1
    redraw!
endfunction

set nowarn

call Svn_diff_windows()
set nowb
