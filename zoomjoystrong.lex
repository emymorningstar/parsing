%{
	#include "zoomjoystrong.tab.h"
	#include <stdlib.h>
%}

%option noyywrap

/*used https://cboard.cprogramming.com/c-programming/95462-compiler-error-warning-implicit-declaration-function-strdup.html for strcpy, used https://cs.gmu.edu/~henryh/330/Lex/comments.html to figure out comments*/



%%

(line)[ ][0-9]+[ ][0-9]+[ ][0-9]+  {strcpy(yylval.str, yytext);return LINE;} 
(point)[ ][0-9]+[ ][0-9]+       { strcpy(yylval.str, yytext); return POINT; }
(circle)[ ][0-9]+[ ][0-9]+[ ][0-9]+ { strcpy(yylval.str, yytext); return CIRCLE; }
(rectangle)[ ][0-9]+[ ][0-9]+[ ][0-9]+[ ][0-9]+ { strcpy(yylval.str, yytext); return RECTANGLE; }
(set_color)[ ][0-9]+[ ][0-9]+[ ][0-9]+ { strcpy(yylval.str, yytext); return SET_COLOR; }
[ \t\n]				            ;
\;                              {return END_STATEMENT;}
.                               {printf("error`");}

%%
