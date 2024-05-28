" Only do this when not done yet for this buffer
if exists('b:did_ft_sh')
	finish
endif
let b:did_ft_sh = 1
setlocal shiftwidth=4
setlocal et
setlocal tw=0
setlocal commentstring=#%s
