%{
    #include <bits/stdc++.h>
    #include "symbolTable.h"
    using namespace std;

    extern FILE *yyin, *yyout;
    SymbolTable T;
    int yylex();
    void yyerror(const char *s){
        fprintf(yyout, "Error: %s\n", s);
    }
    extern int LineNo;
%}



%union {
    int ival;
    float fval;
    double dval;
    char *id;
};


%token <ival> CONST_INT <fval> CONST_FLOAT <dval> CONST_DOUBLE <id> ID
%token SEMICOLON COMMA LPAREN RPAREN LCURL RCURL LTHIRD RTHIRD INT FLOAT DOUBLE
%right ASSIGNOP
%left ADDOP LOGICOP
%left MULOP


%%


mul_stmt: mul_stmt func_decl {
    fprintf(yyout, "Line Number: %d \nmul_stmt: mul_stmt func_decl\n", LineNo);
}
| func_decl {
    // fprintf(yyout, "Line Number: %d \nmul_stmt: func_decl\n", LineNo);
}
;

func_decl: type_spec term LPAREN RPAREN LCURL stmt RCURL {
    fprintf(yyout, "Line Number: %d \nfunc_decl: type_spec term LPAREN RPAREN LCURL stmt RCURL\n", LineNo);
}

;

stmt : stmt unit {
    fprintf(yyout, "Line Number: %d \nstmt : stmt unit\n", LineNo);
}
| unit {
    fprintf(yyout, "Line Number: %d \nstmt : unit\n", LineNo);
}
;

unit : var_decl{
    fprintf(yyout, "Line Number: %d \nunit : var_decl\n", LineNo);
}
| expr_decl{
    fprintf(yyout, "Line Number: %d \nunit : expr_decl\n", LineNo);
}

;

var_decl : type_spec decl_list SEMICOLON {
    fprintf(yyout, "Line Number: %d \nvar_decl : type_spec decl_list SEMICOLON\n", LineNo);
}| error{
    yyerrok;yyclearin;
}
;

type_spec: INT{
    fprintf(yyout, "Line Number: %d \ntype_spec: INT\n", LineNo);
}
|FLOAT {
    fprintf(yyout, "Line Number: %d \ntype_spec: FLOAT\n", LineNo);
}
|DOUBLE{
    fprintf(yyout, "Line Number: %d \ntype_spec: DOUBLE\n", LineNo);
}
;

decl_list: decl_list COMMA term {
    fprintf(yyout, "Line Number: %d \ndecl_list: decl_list COMMA term\n", LineNo);
}
| decl_list COMMA term LTHIRD CONST_INT RTHIRD {
    fprintf(yyout, "Line Number: %d \ndecl_list: decl_list COMMA term LTHIRD CONST_INT RTHIRD\n", LineNo);
}
| term {
    fprintf(yyout, "Line Number: %d \ndecl_list: term\n", LineNo);
}
| term LTHIRD CONST_INT RTHIRD {
    fprintf(yyout, "Line Number: %d \ndecl_list: term LTHIRD CONST_INT RTHIRD\n", LineNo);
}
|ass_list {
    fprintf(yyout, "Line Number: %d \ndecl_list: ass_list\n", LineNo);
}
;

ass_list: term ASSIGNOP expr {
    fprintf(yyout, "Line Number: %d \nass_list: term ASSIGNOP expr\n", LineNo);
}
;

expr: CONST_INT {
    fprintf(yyout, "Line Number: %d \nexpr: CONST_INT\n", LineNo);
}
| CONST_FLOAT {
    fprintf(yyout, "Line Number: %d \nexpr: CONST_FLOAT\n", LineNo);
}
| expr ADDOP expr {
    fprintf(yyout, "Line Number: %d \nexpr: expr ADDOP expr\n", LineNo);
}
| expr MULOP expr {
    fprintf(yyout, "Line Number: %d \nexpr: expr MULOP expr\n", LineNo);
}
| expr LOGICOP expr {
    fprintf(yyout, "Line Number: %d \nexpr: expr LOGICOP expr\n", LineNo);
}
| LPAREN expr RPAREN{
    fprintf(yyout, "Line Number: %d \nexpr: LPAREN expr RPAREN\n", LineNo);
}
|term {
    fprintf(yyout, "Line Number: %d \nexpr: term\n", LineNo);
}
;

term: ID {

    pair<int,int> P = T.lookup($1);
    // fprintf(yyout, "VALUE OF %s is: %d & %d", $1, P.first, P.second);
    if(P.first == -1 and P.second == -1){
        fprintf(yyout, "Line Number: %d \n term: ID %s\n", LineNo,$1);
        SymbolInfo S($1, "ID");
        T.insert(S);
        // T.print(LineNo);
    }
    else{
        fprintf(yyout, "%s is already declared\n", $1);
    }

    // fprintf(yyout, "Line Number: %d \nterm: ID\n", LineNo);
}
;

expr_decl: term ASSIGNOP expr SEMICOLON {
    fprintf(yyout, "Line Number: %d \n term ASSIGNOP expr SEMICOLON\n", LineNo);
}
;



%%


int main()
{
    yyin = fopen("sample_input.txt", "r");
    yyout = fopen("out.txt", "w");
    freopen("Table.txt", "w", stdout);
    yyparse();
    fclose(yyout);
    fclose(yyin);
    T.print();
    return 0;
}