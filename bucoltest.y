%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
void yyerror(const char *s);
%}

%union {
    int num;
    char *str;
}

%token <str> CAPACITY
%token <str> IDENTIFIER
%token <num> INTEGER
%token <str> STRING
%token BEGINNING END BODY MOVE ADD TO INPUT PRINT SEMICOLON DOT QUESTION_MARK PLUS EQUALS

%%

program: BEGINNING declarations BODY statements END { printf("Program is correctly formed\n"); }
       | error { printf("Program is incorrectly formed\n"); }
       ;

declarations: /* empty string */
            | declarations declaration
            ;

declaration: CAPACITY IDENTIFIER INTEGER DOT { printf("Declared variable %s with capacity %d\n", $2, $3); free($2); }
            ;

statements: /* empty string */
          | statements statement
          ;

statement: BEGINNING DOT { printf("Beginning\n"); }
         | CAPACITY IDENTIFIER DOT { printf("Declared variable %s\n", $2); free($2); }
         | BODY DOT { printf("Body\n"); }
         | INPUT IDENTIFIER DOT { printf("Input to variable: %s\n", $2); free($2); }
         | MOVE INTEGER TO IDENTIFIER DOT { printf("Moved value to %s\n", $4); free($4); }
         | ADD IDENTIFIER TO IDENTIFIER DOT { printf("Added value to %s\n", $4); free($4); }
         | print_statement
         | END DOT { printf("End\n"); }
         ;

print_statement: PRINT print_items DOT { printf("Printed items\n"); }
               ;

print_items: print_item
           | print_items SEMICOLON print_item
           ;

print_item: STRING { printf("Printed string: %s\n", $1); free($1); }
          | IDENTIFIER { printf("Printed variable: %s\n", $1); free($1); }
          ;
%%