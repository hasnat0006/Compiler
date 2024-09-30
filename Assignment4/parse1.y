%{
    #include <bits/stdc++.h>
    using namespace std;
    #include "symbolTable.h"
    #define YYSTYPE SymbolInfo
    int yylex();

    SymbolTable T;
    extern FILE* yyout, *yyin;

    SymbolInfo asm_code_store;

    FILE* asm_code;
    FILE* ir;

    void yyerror(const char *s){
        fprintf(yyout, "%s\n", s);
    }

    set<string> v;
    int cnt = 1;
    string ctemp(){
        string s = "t" + to_string(cnt++);
        v.insert(s);
        return s;
    }
    // string assemblyCode = "";

%}


%token NUM ID '(' ')' ';' '{' '}' INT MAIN 
%right '='
%left '+'
%left '-'
%left '/'
%left '*'


%%


prog : MAIN '(' ')' '{' stmt '}' 
    | error {yyerrok; yyclearin;}
    ;

stmt : stmt unit
    | unit
    ;

unit : var_decl
    | expr_decl
    ;

var_decl : type_spec decl_list ';'

type_spec : INT
    ;

decl_list : term
    ;

expr : NUM
    {
        // string temp = ctemp();
        // SymbolInfo obj(temp, "NUM");
        // $$ = obj;
        // assemblyCode += "\tMOV AX, " + $1.getName() + "\n";
        // assemblyCode += "\tMOV " + temp + ", AX\n";
        // fprintf(yyout, "%s = %s\n", temp.c_str(), $1.getName().c_str());
    }
    | expr '+' expr
    {
        string temp = ctemp();
        SymbolInfo obj(temp, "INT");
        $$ = obj;
        // assemblyCode += "\tMOV AX, " + $1.getName() + "\n";
        // assemblyCode += "\tMOV BX, " + $3.getName() + "\n";
        // assemblyCode += "\tADD AX, BX\n";
        // assemblyCode += "\tMOV " + temp + ", AX\n";

        asm_code_store.setCode("MOV AX, " + $1.getName() + "\n");
        asm_code_store.setCode("MOV BX, " + $3.getName() + "\n");
        asm_code_store.setCode("ADD AX, BX\n");
        asm_code_store.setCode("MOV " + temp + ", AX\n");


        fprintf(yyout, "%s = %s + %s\n", temp.c_str(), $1.getName().c_str(), $3.getName().c_str());
    }
    | expr '-' expr
    {
        string temp = ctemp();
        SymbolInfo obj(temp, "INT");
        $$ = obj;
        // assemblyCode += "\tMOV AX, " + $1.getName() + "\n";
        // assemblyCode += "\tMOV BX, " + $3.getName() + "\n";
        // assemblyCode += "\tSUB AX, BX\n";
        // assemblyCode += "\tMOV " + temp + ", AX\n";

        asm_code_store.setCode("MOV AX, " + $1.getName() + "\n");
        asm_code_store.setCode("MOV BX, " + $3.getName() + "\n");
        asm_code_store.setCode("SUB AX, BX\n");
        asm_code_store.setCode("MOV " + temp + ", AX\n");

        fprintf(yyout, "%s = %s - %s\n", temp.c_str(), $1.getName().c_str(), $3.getName().c_str());
    }
    | expr '*' expr
    {
        string temp = ctemp();
        SymbolInfo obj(temp, "INT");
        $$ = obj;
        // assemblyCode += "\tMOV AX, " + $1.getName() + "\n";
        // assemblyCode += "\tMOV BX, " + $3.getName() + "\n";
        // assemblyCode += "\tMUL BX\n";
        // assemblyCode += "\tMOV " + temp + ", AX\n";

        asm_code_store.setCode("MOV AX, " + $1.getName() + "\n");
        asm_code_store.setCode("MOV BX, " + $3.getName() + "\n");
        asm_code_store.setCode("MUL BX\n");
        asm_code_store.setCode("MOV " + temp + ", AX\n");

        fprintf(yyout, "%s = %s * %s\n", temp.c_str(), $1.getName().c_str(), $3.getName().c_str());

    }
    | expr '/' expr
    {
        string temp = ctemp();
        SymbolInfo obj(temp, "INT");
        $$ = obj;
        // assemblyCode += "\tMOV AX, " + $1.getName() + "\n";
        // assemblyCode += "\tMOV BX, " + $3.getName() + "\n";
        // assemblyCode += "\tDIV BX\n";
        // assemblyCode += "\tMOV " + temp + ", AX\n";

        asm_code_store.setCode("MOV AX, " + $1.getName() + "\n");
        asm_code_store.setCode("MOV BX, " + $3.getName() + "\n");
        asm_code_store.setCode("DIV BX\n");
        asm_code_store.setCode("MOV " + temp + ", AX\n");


        fprintf(yyout, "%s = %s / %s\n", temp.c_str(), $1.getName().c_str(), $3.getName().c_str());
    }
    | '(' expr ')'
    {
        $$ = $2;
        // assemblyCode += "\tMOV AX, " + $2.getName() + "\n";
        asm_code_store.setCode("MOV AX, " + $2.getName() + "\n");
    }
    | term
    {
        $$ = $1;
        // assemblyCode += "\tMOV AX, " + $1.getName() + "\n";
        asm_code_store.setCode("MOV AX, " + $1.getName() + "\n");
    }
    ;

term : ID
    {
        SymbolInfo obj;
        obj = yylval;
        pair<int,int> find = T.lookup(obj.getName());
        if(find.first == -1){
            T.insert(obj);
            v.insert(obj.getName());
        }
    }
    ;

expr_decl : term '=' expr ';'
    {
        // assemblyCode += "\tMOV AX, " + $3.getName() + "\n"; 
        // assemblyCode += "\tMOV " + $1.getName() + ", " + "AX"+ "\n\n";
        fprintf(yyout, "%s = %s\n", $1.getName().c_str(), $3.getName().c_str());
        cnt = 1;
    }
    ;

%%

int main(){
    yyin = fopen("input.txt", "r");
    yyout = fopen("three.ir", "w");
    freopen("log.txt", "w", stdout);
    yyparse();

    string FinalCode = ".model small\n.stack 100H\n.data\n";
    for(auto i : v){
        FinalCode += "\t" + i + " DW ?\n";
    }
    FinalCode += ".code\n\n\n";
    FinalCode += "main PROC\n";
    // FinalCode += assemblyCode;
    FinalCode += asm_code_store.getCode();
    FinalCode += "main ENDP\n";
    FinalCode += "END main\n";
    asm_code = fopen("asm_code.asm", "w");
    fprintf(asm_code, "%s", FinalCode.c_str());
    T.print();
    return 0;
}


