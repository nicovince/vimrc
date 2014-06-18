" Vim syntax file for Iceberg
 
syntax clear
 
syn match                   iceLogText      /.*$/ contains=iceWarn,iceError,iceFatal,iceCli,iceRValue,iceRValueKo,tncHeader
syn match                   tncHeader       /\d\+- \+\d \+\[\w\+\] \+(.*):/ skipwhite conceal contains=icewarn,iceError,iceFatal
syn match                   iceHeader       /(\(\w\|\.\)\+[         ]*):/  nextgroup=iceLogText skipwhite contains=iceSpirent,iceMxg,iceMxa conceal
syn match                   iceLevel        /\[\w\+ *\]/ nextgroup=iceHeader skipwhite contains=iceWarn,iceError,iceDebug
syn match                   iceDate         /^.\{-}\d\d:\d\d:\d\d/  nextgroup=iceLevel skipwhite conceal
syn keyword                 iceWarn         contained WARNING
syn keyword                 iceError        contained ERROR
syn keyword                 iceFatal        contained FATAL
syn keyword                 iceDebug        contained DEBUG
syn match                   iceRValueKo     /return value = .*$/
syn match                   iceRValue       /return value = 0x0(0)$/
syn match                   iceCli          /(CLI )>.*$/
syn match                   iceCli          /(TORIS)>.*$/
syn match                   iceBlank        /^ \{10,\}/ conceal
syn case ignore
syn keyword                 iceSpirent      contained SPIRENT
syn match                   iceMxg          contained /\w*MXG\w*/
syn match                   iceMxa          contained /\w*MXA\w*/
syn case match
 
hi link iceRValue           Type
hi link iceRValueKo         ERROR
hi link iceCli                      Question
hi link iceDate             Comment
hi link iceLevel            Title
hi link iceHeader           Comment
hi link iceLogText          Normal
hi link iceWarn                     WarningMsg
hi link iceError            Error
hi link iceDebug            Comment
hi link iceFatal            Error
hi link iceSpirent          Define
hi link iceMxg                      Special
hi link iceMxa                      Special
 
let b:current_syntax="icelog"
