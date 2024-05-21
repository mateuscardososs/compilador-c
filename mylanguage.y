%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%token ID NUM_INT NUM_DEC TEXTO
%token STRUCT INT FLOAT DOUBLE CHAR BOOLEAN
%token <tipo> Tipo

%%

Programa : Declaracao
         | Programa Declaracao
         ;

Declaracao : DeclaracaoVariavel
           | DeclaracaoFuncao
           | DeclaracaoEstrutura
           | Comentario
           ;

DeclaracaoVariavel : Tipo ID ';' 
                   | Tipo ID '=' Expressao ';'
                   ;

DeclaracaoFuncao : Tipo ID '(' Parametros ')' Bloco
                 ;

DeclaracaoEstrutura : STRUCT ID '{' DeclaracaoLista '}' ';'
                    ;

Parametros : Parametro
           | Parametro ',' Parametros
           ;

Parametro : Tipo ID
          | Tipo ID '[' ']'
          | Tipo "..." ID
          ;

Bloco : '{' DeclaracaoLista '}'
      ;

DeclaracaoLista : /* vazio */
                | DeclaracaoLista Declaracao
                ;

Comentario : "//" TEXTO
           | "/" TEXTO "/"
           ;

Expressao : ExpressaoLogica
          ;

ExpressaoLogica : ExpressaoRelacional
                | ExpressaoLogica "&&" ExpressaoRelacional
                | ExpressaoLogica "||" ExpressaoRelacional
                | '!' ExpressaoRelacional
                ;

ExpressaoRelacional : ExpressaoAritmetica
                    | ExpressaoAritmetica '>' ExpressaoAritmetica
                    | ExpressaoAritmetica ">=" ExpressaoAritmetica
                    | ExpressaoAritmetica '<' ExpressaoAritmetica
                    | ExpressaoAritmetica "<=" ExpressaoAritmetica
                    | ExpressaoAritmetica "!=" ExpressaoAritmetica
                    | ExpressaoAritmetica "==" ExpressaoAritmetica
                    ;

ExpressaoAritmetica : ExpressaoMultiplicativa
                    | ExpressaoAritmetica '+' ExpressaoMultiplicativa
                    | ExpressaoAritmetica '-' ExpressaoMultiplicativa
                    ;

ExpressaoMultiplicativa : ExpressaoUnaria
                         | ExpressaoMultiplicativa '*' ExpressaoUnaria
                         | ExpressaoMultiplicativa '/' ExpressaoUnaria
                         | ExpressaoMultiplicativa '%' ExpressaoUnaria
                         ;

ExpressaoUnaria : ExpressaoPostfix
                | '-' ExpressaoUnaria
                | "++" ExpressaoPostfix
                | "--" ExpressaoPostfix
                ;

ExpressaoPostfix : Primaria
                 | Primaria '[' Expressao ']'
                 | Primaria '(' Argumentos ')'
                 | Primaria '.' ID
                 | Primaria "->" ID
                 ;

Argumentos : Expressao
           | /* vazio */
           ;

Primaria : ID
         | NUM_INT
         | NUM_DEC
         | TEXTO
         | '(' Expressao ')'
         ;

%%

int main() {
    yyparse();
    return 0;
}

int yyerror(const char *msg) {
    fprintf(stderr, "Erro: %s\n", msg);
    return 0;
}