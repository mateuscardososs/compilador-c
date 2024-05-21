%{
#include "mylanguage.tab.h"
%}

%%

[ \t\n]                ; // Ignorar espaços em branco e tabulações
"//"([^'\n'])*         ; // Ignorar comentários de linha
"/"([^]\+[^/])"*/" ; // Ignorar comentários de bloco

"int"                  { return INT; }
"float"                { return FLOAT; }
"double"               { return DOUBLE; }
"char"                 { return CHAR; }
"boolean"              { return BOOLEAN; }

[a-zA-Z][a-zA-Z0-9_]* { yylval.sval = strdup(yytext); return ID; }
[0-9]+                 { yylval.ival = atoi(yytext); return NUM_INT; }
[0-9]+"."[0-9]*        { yylval.fval = atof(yytext); return NUM_DEC; }
\"[^"]*\"              { yylval.sval = strdup(yytext); return TEXTO; }

"++"                   { return INCREMENTO; }
"--"                   { return DECREMENTO; }

"+"                    { return MAIS; }
"-"                    { return MENOS; }
"*"                    { return VEZES; }
"/"                    { return DIVIDE; }
"%"                    { return MODULO; }
"="                    { return IGUAL; }
">"                    { return MAIOR; }
">="                   { return MAIORIGUAL; }
"<"                    { return MENOR; }
"<="                   { return MENORIGUAL; }
"!="                   { return DIFERENTE; }
"=="                   { return IGUALIGUAL; }
"&&"                   { return ELOGICO; }
"||"                   { return OULOGICO; }
"!"                    { return NEGACAO; }

"."                    { return PONTO; }
"->"                   { return SETA; }

"("                    { return ABREPARENTESES; }
")"                    { return FECHAPARENTESES; }
"["                    { return ABRECOLCHETES; }
"]"                    { return FECHACOLCHETES; }
"{"                    { return ABRECHAVES; }
"}"                    { return FECHACHAVES; }

";"                    { return PONTOEVIRGULA; }
","                    { return VIRGULA; }

.    { fprintf(stderr, "Caractere inesperado: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}