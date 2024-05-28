" Only do this when not done yet for this buffer
if exists('b:did_ft_make')
	finish
endif
let b:did_ft_make = 1
"
" Let the matchit plugin know what items can be matched.
if exists('loaded_matchit')
  let b:match_ignorecase=0
  let b:match_words=
    \ 'ifn\?def\>\|\<ifn\?eq\>:else\>:endif\>,'
  set noet
endif
