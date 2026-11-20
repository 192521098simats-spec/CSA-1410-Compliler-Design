%{
#include "parser.tab.h"
#include <stdlib.h>
#include <string.h>
%}
%option noyywrap
%%
[ \t\r\n]+                 ;
"int"                      { return INT; }
"float"                    { return FLOAT; }
"if"                       { return IF; }
"else"                     { return ELSE; }
"while"                    { return WHILE; }
"=="                       { return EQ; }
"!="                       { return NE; }
"<="                       { return LE; }
">="                       { return GE; }
[0-9]+(\.[0-9]+)?          { yylval.str = strdup(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]*     { yylval.str = strdup(yytext); return ID; }
[+\-*/=<>;,(){}]            { return yytext[0]; }
.                          { fprintf(stderr,"Lexical error: %s\n",yytext); }
%%
