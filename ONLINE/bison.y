%{
    #include <bits/stdc++.h>
    using namespace std;
    extern FILE *yyin, *yyout;
    FILE *syn;
    int yylex();
    extern int line;

    void yyerror(const char *s) {
        fprintf(syn, "Line no: %d -- Error: %s\n", line, s);
    }
%}

%union {
    char* sval;
    int ival;
}

%token <sval> VARIABLE <sval> STRING <ival> NUMBER
%token EC IF FI THEN SEMICOLON FOR DO DONE IN PIPE LS WC EQ


%%

statement_list : statement {
    fprintf(syn, "Line no: %d -- statement_list : statement\n", line);
}
| statement_list statement {
    fprintf(syn, "Line no: %d -- statement_list : statement_list statement\n", line);
}
| error{
    yyerrok; yyclearin;
}
statement : command SEMICOLON {
    fprintf(syn, "Line no: %d -- statement : command SEMICOLON\n", line);
}
| if_statement {
    fprintf(syn, "Line no: %d -- statement : if_statement\n", line);
}
| for_loop {
    fprintf(syn, "Line no: %d -- statement : for_loop\n", line);
}


if_statement : IF condition THEN statement_list FI {
    fprintf(syn, "Line no: %d -- if_statement : IF condition THEN statement_list FI\n", line);
}

condition : VARIABLE EQ NUMBER {
    fprintf(syn, "Line no: %d -- condition : VARIABLE EQ NUMBER\n", line);
}

for_loop : FOR VARIABLE IN variable_list DO statement_list DONE {
    fprintf(syn, "Line no: %d -- for_loop : FOR VARIABLE IN variable_list DO statement_list DONE\n", line);
}

command : EC VARIABLE {
    fprintf(syn, "Line no: %d -- command : EC VARIABLE\n", line);
}
| EC STRING {
    fprintf(syn, "Line no: %d -- command : EC STRING\n", line);
}
| LS {
    fprintf(syn, "Line no: %d -- command : LS\n", line);
}
| WC {
    fprintf(syn, "Line no: %d -- command : WC\n", line);
}
| command PIPE command {
    fprintf(syn, "Line no: %d -- command : command PIPE command\n", line);
}
variable_list : VARIABLE {
    fprintf(syn, "Line no: %d -- variable_list : VARIABLE\n", line);
}
| variable_list VARIABLE{
    fprintf(syn, "Line no: %d -- variable_list : variable_list VARIABLE\n", line);
}

%%

int main() {
    yyin = fopen("input.txt", "r");
    yyout = fopen("output.txt", "w");
    syn = fopen("syntax_errors.txt", "w");
    if (!yyin || !yyout || !syn) {
        fprintf(stderr, "Error opening files.\n");
        return 1;
    }
    yyparse();
    fclose(yyin);
    fclose(yyout);
    fclose(syn);
    return 0;
}