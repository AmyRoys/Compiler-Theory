%{
#include "calc.tab.h"
%}

%option noyywrap

%%

[0-9]+ { yylval = atoi(yytext); return NUMBER; }
\n { return EOL; }
"+" { return ADD; }
"-" { return SUB; }
"*" { return MUL; }
"/" { return DIV; }

[ \t] { /* ignore whitespace */ }
. { printf("Unknown character: %s\n", yytext); }

%%