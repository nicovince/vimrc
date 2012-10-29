" vhdl_snippet.vim
if exists(':StringAbbrLocal') != 2
  finish
endif
let b:CodeSnippet_opener = '[~'
let b:CodeSnippet_closer = '~]'
StringAbbrLocal _process_ "process(CLK,RST)\nbegin\nif RST='1' then\n[~statements~]\nelsif rising_edge(CLK) then\n[~statements~]\nend if;\nend process;"
StringAbbrLocal _if_ "if [~cond~] then\n[~statements~]\nend if;"
StringAbbrLocal _elsif_ "elsif [~cond~] then\n[~statements~]"
StringAbbrLocal _entity_ "entity [~entity_name~]\ngeneric map\n( [~generic_parameters~]\n)\nport map\n( [~signals~]\n);"
StringAbbrLocal _function_ "function [~func_name~] return [~return_type~] is\nbegin\n[~func_body~]\nend function;\n"
StringAbbrLocal _procedure_ "procedure [~proc_name~] is\nbegin\n[~proc_body~]\nend procedure;\n"
