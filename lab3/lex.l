%option noyywrap
%{
#include<stdio.h>
#include "symbolTable.h"
SymbolTable table;
FILE* log_file;
int line_cnt=1;

%}

%%
\n      {
            line_cnt++;
        }

int     {
            fprintf(yyout, "<INT>");
        }
[a-zA-Z]+ {
            fprintf(yyout, "<ID, %s>\n", yytext);
            SymbolInfo temp("ID", yytext);
            table.insert(temp);
            fprintf(log_file, "Line %d: Token <ID> Lexeme %s\n", line_cnt, yytext);
        }

[0-9]+  {
            fprintf(yyout, "<CONST_INT, %s>\n", yytext);
        }
=       {
            fprintf(yyout, "<ASSIGN_OP, %s>\n", yytext);
        }
;       {
            fprintf(yyout, "<SEMICOLON, %s>\n", yytext);
        }

%%

int main(){
    yyin = fopen("in.txt", "r");
    yyout = fopen("token.txt", "w");
    log_file = fopen("log.txt", "w");
    yylex();
    return 0;
}