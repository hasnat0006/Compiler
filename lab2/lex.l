%option noyywrap
%{

#include<stdio.h>
int cnt_line=0;

%}
start [_a-zA-Z]
id {start}[a-zA-Z0-9]+ 

%%

[0-9]+  {
            fprintf(yyout, "<NUM, Lexeme=%s, length=%d>\n", yytext, yyleng);
            cnt_line++;
        }
{id}    {
            fprintf(yyout, "<ID, Lexeme=%s, length=%d>\n", yytext, yyleng);
            cnt_line++;
        }
.*      {
            fprintf(yyout, "Other pattern\n");
            cnt_line++;
        } 

%%

int main(){
    yyin = fopen("in.txt", "r");
    yyout = fopen("out.txt", "w");
    yylex();
    printf("Total linenumber = %d\n", cnt_line);
    return 0;
}