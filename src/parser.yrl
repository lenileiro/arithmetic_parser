Nonterminals expression term factor primary.
Terminals num op_add op_sub op_mul op_div paren_open paren_close.
Rootsymbol expression.

%% Handle expressions with parentheses and addition/subtraction
expression -> expression op_add term : {op_add, '$1', '$3', element(2, '$2')}.
expression -> expression op_sub term : {op_sub, '$1', '$3', element(2, '$2')}.
expression -> term : '$1'.

%% Handle multiplication and division with higher precedence
term -> term op_mul factor : {op_mul, '$1', '$3', element(2, '$2')}.
term -> term op_div factor : {op_div, '$1', '$3', element(2, '$2')}.
term -> factor : '$1'.

%% Factor handles the immediate numbers or parenthesized expressions
factor -> primary : '$1'.
factor -> paren_open expression paren_close : '$2'.

%% Primary is a numerical value
primary -> num : extract('$1').


Erlang code.

extract({T,_,V}) -> {T, V}.