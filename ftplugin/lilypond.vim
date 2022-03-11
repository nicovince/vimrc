" Only do this when not done yet for this buffer
if exists('b:did_ftplugin_ly')
	finish
endif
let b:did_ftplugin_ly = 1

setlocal iskeyword=@,48-57,_,192-255,#
