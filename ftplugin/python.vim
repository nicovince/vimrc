" Only do this when not done yet for this buffer
if exists('b:did_ftplugin')
	finish
endif
setlocal shiftwidth=4
setlocal et

" Sequans PI config :
if (IsSequansPI())
        setlocal shiftwidth=4
        setlocal tabstop=4
        setlocal noet
elseif (IsZephyr())
        setlocal textwidth=100
endif
