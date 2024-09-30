
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     CONST_INT = 258,
     CONST_FLOAT = 259,
     CONST_DOUBLE = 260,
     ID = 261,
     SEMICOLON = 262,
     COMMA = 263,
     LPAREN = 264,
     RPAREN = 265,
     LCURL = 266,
     RCURL = 267,
     LTHIRD = 268,
     RTHIRD = 269,
     INT = 270,
     FLOAT = 271,
     DOUBLE = 272,
     ASSIGNOP = 273,
     LOGICOP = 274,
     ADDOP = 275,
     MULOP = 276
   };
#endif
/* Tokens.  */
#define CONST_INT 258
#define CONST_FLOAT 259
#define CONST_DOUBLE 260
#define ID 261
#define SEMICOLON 262
#define COMMA 263
#define LPAREN 264
#define RPAREN 265
#define LCURL 266
#define RCURL 267
#define LTHIRD 268
#define RTHIRD 269
#define INT 270
#define FLOAT 271
#define DOUBLE 272
#define ASSIGNOP 273
#define LOGICOP 274
#define ADDOP 275
#define MULOP 276




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 17 ".\\112a3.y"

    int ival;
    float fval;
    double dval;
    char *id;



/* Line 1676 of yacc.c  */
#line 103 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


