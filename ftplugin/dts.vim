" Only do this when not done yet for this buffer
if exists('b:did_ft_dts')
        finish
endif
let b:did_ft_dts = 1

setlocal noexpandtab
setlocal shiftwidth=8
