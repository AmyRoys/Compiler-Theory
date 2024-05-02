%{
    #include <stdio.h>
    extern int yylex(); 
    void yyerror(const char *s); 

%}

%token NUMBER
%token ADD SUB MUL DIV
%token EOL

%left ADD SUB
%left MUL DIV

%%

calculation: /* empty string */
    | calculation line
    ; 

line: EOL
    | expression EOL {printf("= %d\n", $1);}

expression: NUMBER
    | expression ADD expression { $$ = $1 + $3;}
    | expression SUB expression { $$ = $1 - $3;}
    | expression MUL expression { $$ = $1 * $3;}
    | expression DIV expression { $$ = $1 / $3;}
    ;

%%

void yyerror(const char *s){
    fprintf(stderr, "Error: %s\n", s);
}

int main(){
    yyparse(); 
    return 0; 
}