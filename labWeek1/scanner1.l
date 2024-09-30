%option noyywrap

%{
    #include <stdio.h>
    #include "symbolTable.h"
    #define YYSTYPE SymbolInfo
    #include "parse1.tab.h"
%}


%%


[ \t\n]+    { /* ignore whitespace */ }
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
[-+=();]    { return *yytext; }
.           { printf("Error!"); }


%%