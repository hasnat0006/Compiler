%option noyywrap


%{
    #include<bits/stdc++.h>
    #include "y.tab.h"
    using namespace std;
    int line = 1;
%}


digits [0-9]+
string \"([^\\\"]|\\.)*\"
char   [a-zA-Z]+
var    "$"{char}


%%

\n {
    line++;
}

"echo"   {
    return EC;
    fprintf(yyout, "<-----------%s, KEYWORD>\n", yytext);
}

"if"     {
    return IF;
    fprintf(yyout, "<-----------%s, KEYWORD>\n", yytext);
}
"fi"     {
    return FI;
    fprintf(yyout, "<-----------%s, KEYWORD>\n", yytext);
}
"then"   {
    return THEN;
    fprintf(yyout, "<-----------%s, KEYWORD>\n", yytext);
}
";"      {
    return SEMICOLON;
    fprintf(yyout, "<-----------%s, KEYWORD>\n", yytext);
}
"for"      {
    return FOR;
    fprintf(yyout, "<-----------%s, KEYWORD>\n", yytext);
}
"in"      {
    return IN;
    fprintf(yyout, "<-----------%s, KEYWORD>\n", yytext);
}
"do"      {
    return DO;
    fprintf(yyout, "<-----------%s, KEYWORD>\n", yytext);
}
"done"    {
    return DONE;
    fprintf(yyout, "<-----------%s, KEYWORD>\n", yytext);
}
"ls"      {
    return LS;
}
"wc"      {
    return WC;
}
"="     {
    return EQ;
}
"\|"      {
    return PIPE;
    fprintf(yyout, "<-----------%s, KEYWORD>\n", yytext);
}


{digits} {
    fprintf(yyout, "<%s, NUMBER>\n", yytext);
    yylval.ival = atoi(yytext); 
    return NUMBER;
} 
{string} {
    fprintf(yyout, "<%s, STRING>\n", yytext);
    yylval.sval = strdup(yytext); 
    return STRING;
}
{var}    {
    fprintf(yyout, "<%s, VARIABLE>\n", yytext);
    yylval.sval = strdup(yytext); 
    return VARIABLE;
}



. {

}


%%

