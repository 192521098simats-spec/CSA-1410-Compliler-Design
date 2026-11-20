%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef struct Node {
    char label[64];
    struct Node *left, *right;
} Node;
Node *mk(const char *s, Node *l, Node *r) {
    Node *n=(Node*)calloc(1,sizeof(Node));
    snprintf(n->label,sizeof(n->label),"%s",s);
    n->left=l; n->right=r; return n;
}
void printTree(Node *n,int d) {
    if(!n) return;
    for(int i=0;i<d;i++) printf("  ");
    printf("%s\n",n->label);
    printTree(n->left,d+1); printTree(n->right,d+1);
}
int tempNo=0;
char *newTemp(void) {
    char *s=(char*)malloc(16); sprintf(s,"t%d",++tempNo); return s;
}
void yyerror(const char *s);
int yylex(void);
%}
%union { char *str; Node *node; }
%token INT FLOAT IF ELSE WHILE
%token <str> ID NUMBER
%token EQ NE LE GE
%type <node> expr term factor
%left '+' '-'
%left '*' '/'
%right UMINUS
%%
program : items ;
items   : items item | item ;
item    : declaration
        | statement
        ;
declaration
        : INT idlist ';'   { puts("Declaration type=int"); }
        | FLOAT idlist ';' { puts("Declaration type=float"); }
        ;
idlist  : idlist ',' ID { printf("  addType(%s)\n",$3); }
        | ID            { printf("  addType(%s)\n",$1); }
        ;
statement
        : ID '=' expr ';' {
              printf("Assignment to %s\n",$1);
              printf("AST:\n"); printTree($3,0);
          }
        | IF '(' condition ')' statement
        | IF '(' condition ')' statement ELSE statement
        | WHILE '(' condition ')' statement
        | '{' items '}'
        ;
condition
        : expr '<' expr | expr '>' expr | expr EQ expr
        | expr NE expr | expr LE expr | expr GE expr
        ;
expr    : expr '+' term { $$=mk("+",$1,$3); }
        | expr '-' term { $$=mk("-",$1,$3); }
        | term          { $$=$1; }
        ;
term    : term '*' factor { $$=mk("*",$1,$3); }
        | term '/' factor { $$=mk("/",$1,$3); }
        | factor          { $$=$1; }
        ;
factor  : '(' expr ')' { $$=$2; }
        | ID            { $$=mk($1,NULL,NULL); }
        | NUMBER        { $$=mk($1,NULL,NULL); }
        | '-' factor %prec UMINUS { $$=mk("NEG",$2,NULL); }
        ;
%%
void yyerror(const char *s) { fprintf(stderr,"Syntax error: %s\n",s); }
int main(void) {
    puts("MINILANG FLEX/BISON TRANSLATOR");
    puts("-----------------------------");
    if(yyparse()==0) puts("Parsing completed.");
    return 0;
}
