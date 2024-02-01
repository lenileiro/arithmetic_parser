Definitions.
NUM = [0-9]+
OP_ADD = [\+]
OP_SUB = [-]
OP_MUL = [*]
OP_DIV = [/]
PAREN_OPEN = [(]
PAREN_CLOSE = [)]
WHITESPACE=[\s\t\r\n]+
UNEXPECTED_WORD = [a-zA-Z]+

Rules.
{NUM} : {token, {num, TokenLine, list_to_integer(TokenChars)}}.
{OP_ADD} : {token, {op_add, TokenLine, TokenChars}}.
{OP_SUB} : {token, {op_sub, TokenLine, TokenChars}}.
{OP_MUL} : {token, {op_mul, TokenLine, TokenChars}}.
{OP_DIV} : {token, {op_div, TokenLine, TokenChars}}.
{PAREN_OPEN} : {token, {paren_open, TokenLine, TokenChars}}.
{PAREN_CLOSE} : {token, {paren_close, TokenLine, TokenChars}}.
{WHITESPACE} : skip_token.
{UNEXPECTED_WORD} : {token, {error, TokenLine, {unexpected_chars, list_to_atom(TokenChars)}}}.
.     : {token, {error, TokenLine, {unexpected_char, list_to_atom(TokenChars)}}}.


Erlang code.
