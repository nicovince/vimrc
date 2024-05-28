" Only do this when not done yet for this buffer
if exists('b:did_ft_do')
	finish
endif
let b:did_ft_do = 1
setlocal shiftwidth=2
setlocal ai
setlocal et
