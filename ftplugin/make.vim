" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1
"
" Let the matchit plugin know what items can be matched.
if exists("loaded_matchit")
  let b:match_ignorecase=0
  let b:match_words=
    \ 'ifn\?def\>\|\<ifeq\>:else\>:endif\>,'
  set noet
endif
