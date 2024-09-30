%option noyywrap

%{
   #include <bits/stdc++.h>
   #include "y.tab.h"
   #include "symbolTable.h"
   using namespace std;
   int LineNo = 1;
%}


CHAR [a-zA-Z]
CHARS {CHAR}+
DIGIT [0-9]
DIGITS {DIGIT}+
INT_NUM {DIGITS}([Ee][-+]?{DIGITS})?
FLOAT_NUM {DIGITS}?"."{DIGITS}([Ee][-+]?{DIGITS})?
ID (((_)+({CHARS}|{DIGITS}|[_])*)|({CHARS}))({CHARS}|{DIGITS}|[_])*

%%

[\n]     {
   LineNo++;
}
[ \t]    {}

int {
   return INT;
}
float {
   return FLOAT;
}
double {
   return DOUBLE;
}


{INT_NUM} {
   yylval.ival = atoi(yytext);
   return CONST_INT;
}  

{FLOAT_NUM} {
   yylval.fval = atof(yytext);
   return CONST_FLOAT;
}

{ID} {
   yylval.id = strdup(yytext);
   return ID;
}

"+"|"-" {
   return ADDOP;
}
"*"|"%"|"/" {
   return MULOP;
}
"&&"|"||" {
   return LOGICOP;
}

[=] {
   return ASSIGNOP;
}
[;] {
   return SEMICOLON;
}
[,] {
   return COMMA;
}
"(" {
   return LPAREN;
}
")" {
   return RPAREN;
}
"{" {
   return LCURL;
}
"}" {
   return RCURL;
}
"[" {
   return LTHIRD;
}
"]" {
   return RTHIRD;
}


. {
}

%%
