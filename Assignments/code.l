%option noyywrap

%{

#include<stdio.h>
#include "symbolTable.h"
SymbolTable table;
int line_cnt=1;
int error_cnt=0;

%}

CHAR [a-zA-Z]
CHARS {CHAR}+
DIGIT [0-9]
DIGITS {DIGIT}+
INT_NUM {DIGITS}([Ee][-+]?{DIGITS})?
FLOAT_NUM {DIGITS}?"."{DIGITS}([Ee][-+]?{DIGITS})?
ID (((_)+({CHARS}|{DIGITS}|[_])*)|({CHARS}))({CHARS}|{DIGITS}|[_])*
MULTI_COMMENT \/\*([^*]|\*+[^/])*?\*\/
SINGLE_COMMENT \/\/.*
KEYWORD if|else|for|while|do|break|int|char|float|double|void|return|switch|case|default|continue

%%
\n      {
    line_cnt++;
}
[ \t]   {
    
}

{KEYWORD} {
    fprintf(yyout, "<%s>", yytext);
    cout << "Line No: " << line_cnt << " Token <" << toUpper(yytext) << "> Lexeme " << yytext << " found\n";
}

{INT_NUM}  {
    fprintf(yyout, "<CONST_INT, %s>", yytext);
    cout << "Line No: " << line_cnt << " Token <CONST_INT> Lexeme " << yytext << " found\n";
    SymbolInfo temp(yytext, "CONST_INT");
    table.insert(temp);

}
{FLOAT_NUM} {
    fprintf(yyout, "<CONST_FLOAT, %s>", yytext);
    cout << "Line No: " << line_cnt << " Token <CONST_FLOAT> Lexeme " << yytext << " found\n";
    SymbolInfo temp(yytext, "CONST_FLOAT");
    table.insert(temp);

}
('.') {
    string value; 
    value.push_back(yytext[1]);
    fprintf(yyout, "<CONST_CHAR, %c>", value[0]);
    cout << "Line No: " << line_cnt << " Token <CONST_CHAR> Lexeme " << value << " found\n";
    SymbolInfo temp(value, "CONST_CHAR");
    table.insert(temp);

}

{ID}    {
    fprintf(yyout, "<ID, %s>", yytext);
    cout << "Line No: " << line_cnt << " Token <ID> Lexeme " << yytext << " found\n";
    SymbolInfo temp(yytext, "ID");
    table.insert(temp);

}


{SINGLE_COMMENT}|{MULTI_COMMENT} {
    cout << "Line No: " << line_cnt << " Token <COMMENT> Lexeme " << yytext << " found\n";
}

({DIGIT}+{ID}+) {
    cout << "Error at Line No: " << line_cnt << " Invalid prefix on ID or invalid suffix on Number " << yytext << endl;
    error_cnt++;
}

(({FLOAT_NUM}|".")(([Ee][+-]?)?\.?{DIGITS})+) {
    cout << "Error at Line No: " << line_cnt << " Ill formed number " << yytext << endl;
    error_cnt++;
}
({INT_NUM}(([Ee][+-]?)?\.?{DIGITS})+) {
    cout << "Error at Line No: " << line_cnt << " Ill formed number " << yytext << endl;
    error_cnt++;
}

({DIGITS}".")+([Ee][+-]?{DIGITS}?"."?{DIGITS}?)+ {
    cout << "Error at Line No: " << line_cnt << " Ill formed number " << yytext << endl;
    error_cnt++;
}

(\'\') {
    cout << "Error at Line No: " << line_cnt << " Empty character constant " << yytext << "\n";
    error_cnt++;
}


[-+] {
    fprintf(yyout, "<ADDOP, %s>", yytext);
    cout << "Line No: " << line_cnt << " Token <ADDOP> Lexeme " << yytext << " found\n";

}
[*/%] {
    fprintf(yyout, "<MULOP, %s>", yytext);
    cout << "Line No: " << line_cnt << " Token <MULOP> Lexeme " << yytext << " found\n";
}
(--)|(\+\+) {
    fprintf(yyout, "<INCDEC_OP, %s>", yytext);
    cout << "Line No: " << line_cnt << " Token <INCDEC_OP> Lexeme " << yytext << " found\n";
}
(<)|(<=)|(>)|(>=)|(==)|(!=) {
    fprintf(yyout, "<RELOP, %s >", yytext);
    cout << "Line No: " << line_cnt << " Token <RELOP> Lexeme " << yytext << " found\n";
}
= {
    fprintf(yyout, "<ASSIGNOP, %s >", yytext);
    cout << "Line No: " << line_cnt << " Token <ASSIGNOP> Lexeme " << yytext << " found\n";
}
(&&)|(\|\|) {
    fprintf(yyout, "<LOGICALOP, %s >", yytext);
    cout << "Line No: " << line_cnt << " Token <LOGICALOP> Lexeme " << yytext << " found\n";
}
! {
    fprintf(yyout, "<NOT, %s >", yytext);
    cout << "Line No: " << line_cnt << " Token <NOT> Lexeme " << yytext << " found\n";
}
(\() {
    fprintf(yyout, "<LPAREN, %s>", yytext);
    cout << "Line No: " << line_cnt << " Token <LPAREN> Lexeme " << yytext << " found\n";
}
(\)) {
    fprintf(yyout, "<RPAREN, %s>", yytext);
    cout << "Line No: " << line_cnt << " Token <RPAREN> Lexeme " << yytext << " found\n";
}
[\{] {
    fprintf(yyout, "<LCURL, %s>", yytext);
    cout << "Line No: " << line_cnt << " Token <LCURL> Lexeme " << yytext << " found\n";
}
[\}] {
    fprintf(yyout, "<RCURL, %s>", yytext);
    cout << "Line No: " << line_cnt << " Token <RCURL> Lexeme " << yytext << " found\n";
}
[\[] {
    fprintf(yyout, "<LTHIRD, %s>", yytext);
    cout << "Line No: " << line_cnt << " Token <LTHIRD> Lexeme " << yytext << " found\n";
}
[\]] {
    fprintf(yyout, "<RTHIRD, %s>", yytext);
    cout << "Line No: " << line_cnt << " Token <RTHIRD> Lexeme " << yytext << " found\n";
}
[,] {
    fprintf(yyout, "<COMMA, %s>", yytext);
    cout << "Line No: " << line_cnt << " Token <COMMA> Lexeme " << yytext << " found\n";
}
[;] {
    fprintf(yyout, "<SEMICOLON, %s>", yytext);
    cout << "Line No: " << line_cnt << " Token <SEMICOLON> Lexeme " << yytext << " found\n";
}

. {
    cout << "Error at Line " << line_cnt << ": Unrecognized char " << yytext << "\n";
}

%%

int main(int argc, char *argv[]){
    yyin = fopen(argv[1], "r");
    yyout = fopen("202214112_token.txt", "w");
    freopen("202214112_log.txt", "w", stdout); 
    yylex();
    cout << "Total number of errors: " << error_cnt << "\n";
    return 0;
}