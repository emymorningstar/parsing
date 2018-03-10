%{
	#include "zoomjoystrong.tab.h"
	#include <stdlib.h>
	#include <string.h>
%}

%option noyywrap

/*used https://cboard.cprogramming.com/c-programming/95462-compiler-error-warning-implicit-declaration-function-strdup.html for strcpy, used https://cs.gmu.edu/~henryh/330/Lex/comments.html to figure out comments*/



%%

(line) 					{ printf("\nLINE ");return LINE;} 
(point) 				{ printf("\nPOINT ");  return POINT; }
(circle)				{ printf("\nCIRCLE "); return CIRCLE; }
(rectangle)				{ printf("\nRECTANGLE "); return RECTANGLE; }
(set_color)				{ printf("\nSET_COLOR "); return SET_COLOR; }
[0-9]+					{ yylval.i = atoi(yytext);   printf("%d ", yylval.i); return INT;}
-[0-9]+					{yylval.i = atoi(yytext);	printf("%d ", yylval.i); return INT;}
\;                              {return END_STATEMENT;}
[ \t\n]					;

.                              {printf("\nerror\n"); return ERROR_INPUT;}
%%
