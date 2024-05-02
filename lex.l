%{
/*
* this sample demonstrates (very) simple recognition: not a verb / a verb (and
then only selected ones!)
*/
%}
%%
[\t ]+ /* ignore whitespace */ ;
is |
am |
are |
were |
was |
be { printf("%s: is a verb\n", yytext); }
[a-zA-Z]+ {printf("%s: is not a verb\n", yytext); }
.|\n { ECHO; /* normal default anyway*/ }
%%
int main(){
    yylex();
    return 0; 
}
int yywrap()
{
   return 1;
}