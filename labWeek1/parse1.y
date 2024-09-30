%{
    #include <bits/stdc++.h>
    using namespace std;
    #include "symbolTable.h"
    #define YYSTYPE SymbolInfo
    int yylex();
    extern FILE* yyout;
    void yyerror(const char *s){
        fprintf(yyout, "%s\n", s);
    }

    int cnt = 1;

    char* ctemp(){
        char *temp;
        temp = (char*)malloc(10 * sizeof(char));
        sprintf(temp, "t%d", cnt);
        cnt++;
        return temp;
    }

%}


%token NUM ID '(' ')' ';' 
%left '+' '-'
%right '='


%%


stmt : stmt line
    | line
    ;

line : ID '=' expr ';' {
                        printf("%s = %s\n", $1.getName().c_str(), $3.getName().c_str());
                        cnt = 1;

                        // ASM CODE
                        fprintf(yyout, "MOV %s, %s\n\n\n", $1.getName().c_str(), $3.getName().c_str());
                    }
    | expr ';'      { cnt = 1; }
    ;

expr : expr '+' expr  {
                        char* temp = ctemp();
                        SymbolInfo obj(temp, "TempVar");
                        $$ = obj;
                        printf("%s = %s + %s\n", $$.getName().c_str(), $1.getName().c_str(), $3.getName().c_str()); 

                        // ASM CODE
                        fprintf(yyout, "MOV AX, %s\n", $1.getName().c_str());
                        fprintf(yyout, "ADD AX, %s\n", $3.getName().c_str());
                        fprintf(yyout, "MOV %s, AX\n", $$.getName().c_str());

                    }
    | expr '-' expr   {
                        char* temp = ctemp();
                        SymbolInfo obj(temp, "TempVar");
                        $$ = obj;
                        printf("%s = %s - %s\n", $$.getName().c_str(), $1.getName().c_str(), $3.getName().c_str()); 
                    }
    | '(' expr ')'   { $$ = $2; }
    | ID
    | NUM
    ;


%%

int main(){
    yyout = fopen("asm.txt", "w");
    yyparse();
    return 0;
}


