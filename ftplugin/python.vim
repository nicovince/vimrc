" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
	finish
endif
setlocal shiftwidth=4
setlocal et

" Sequans PI python config :
if exists("b:envPi")
        setlocal shiftwidth=8
        setlocal noet
endif
