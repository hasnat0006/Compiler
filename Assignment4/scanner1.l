%option noyywrap

%{
    #include <stdio.h>
    #include "symbolTable.h"
    #define YYSTYPE SymbolInfo
    #include "y.tab.h"
%}


%%


[ \t\n]+    { /* ignore whitespace */ }
int        {
                SymbolInfo obj(yytext, "INT");
                yylval = obj;
                return INT;
            }
main        {
                SymbolInfo obj(yytext, "MAIN");
                yylval = obj;
                return MAIN;
            }

[0-9]+      {
                SymbolInfo obj(yytext, "NUM");
                yylval = obj;
                return NUM;
            }
[a-zA-Z]+   {
                SymbolInfo obj(yytext, "ID");
                yylval = obj;
                return ID;
            }
[-+=();{}*/]    { return *yytext; }
.           { printf("Error!"); }



%%