" Mon fichier de types de fichiers
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.reg setfiletype reg
  au BufNewFile,BufRead *.tt2 setf tt2
augroup END
