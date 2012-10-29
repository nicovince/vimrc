" verilog_snippet.vim
if exists(':StringAbbrLocal') != 2
  finish
endif
let b:CodeSnippet_opener = '[~'
let b:CodeSnippet_closer = '~]'
StringAbbrLocal _always_ "always @(posedge CLK or negedge RSTN) begin\nif (!RSTN) begin\n[~reset~]\nend else begin\n[~statements~]\nend\nend"
StringAbbrLocal _if_ "if [~cond~] begin\n [~statements~]\nend"
StringAbbrLocal _else_ "end else begin"
