" Only do this when not done yet for this buffer
if exists('b:did_ft_cmake')
        finish
endif
let b:did_ft_cmake = 1

setlocal noet

if (IsZephyr())
        setlocal shiftwidth=2
        setlocal tabstop=2
        setlocal expandtab
endif

