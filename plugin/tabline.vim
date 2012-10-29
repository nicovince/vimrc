if v:version >= 700
else
  finish
endif

"===============================================================================
" Custom tab line
"===============================================================================
function! MyTabLabel(n)

  let label   =  ''

  let label  .=  '['                             

  let label  .=  a:n                             " set tab page number

  let buflist = tabpagebuflist(a:n)
  
  for bufnr in buflist
    if getbufvar(bufnr, '&modified')             " unsaved modified buffer?
      let label .= '+'
      break
    endif
  endfor
  
  let wincount = tabpagewinnr(a:n, '$')          " number of windows in tab
  if wincount > '1'
    let label .= ',' . wincount                  " report how many windows
  endif

  let label  .=  '] '                            " close bracket

  let winnr    = tabpagewinnr(a:n)               " focused window number
  let fullname = bufname(buflist[winnr - 1])     " absolute file name
  let filename = fnamemodify(fullname, ':t')     " basename

  if filename == ''                              " empty buffers have No Name
    let filename = '[No Name]'
  endif

  let label   .= filename                        " add filename to label

  return label

endfunction

function! MyTabLine()

  let s = ''

  for i in range(tabpagenr('$'))                 " for each open tab..

    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'                   " make active tab stand out 
    else
      let s .= '%#TabLine#'                      
    endif

    let s .= '%{MyTabLabel(' . (i + 1) . ')}'    " add tab label 

    let s .= '%#TabLine#'                        " reset highlight

    if i + 1 != tabpagenr('$')
      let s .= ' | '                             " fancy tab separator
    else
      let s .= '   '                             " except for the last tab
    endif

  endfor

  let s .= '%#TabLineFill#%T'                    " :help statusline

  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999XX'                " right align the final 'X'
  endif

  return s

endfunction



function! MyTabLine2()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} |'
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999X X'
  endif

  "echomsg 's:' . s
  return s
endfunction

function! MyTabLabel2(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let numtabs = tabpagenr('$')
  " account for space padding between tabs, and the "close" button
  let maxlen = ( &columns - ( numtabs * 2 ) - 4 ) / numtabs
  let tablabel = bufname(buflist[winnr - 1])
  while strlen( tablabel ) < 4
    let tablabel = tablabel . " "
  endwhile
  let tablabel = fnamemodify( tablabel, ':t' )
  let tablabel = strpart( tablabel, 0, maxlen )
  return tablabel
endfunction

" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)
  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '+'
      break
    endif
  endfor
  " Append the tab number
  let label .= v:lnum.': '
  " Append the buffer name
  let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
  if name == ''
    " give a name to no-name documents
    if &buftype=='quickfix'
      let name = '[Quickfix List]'
    else
      let name = '[No Name]'
    endif
  else
    " get only the file name
    let name = fnamemodify(name,":t")
  endif
  let label .= name
  " Append the number of windows in the tab page
  let wincount = tabpagewinnr(v:lnum, '$')
  return label . '  [' . wincount . ']'
endfunction
