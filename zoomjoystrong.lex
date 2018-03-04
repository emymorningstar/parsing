%{
	#include "zoomjoystrong.tab.h"
	#include <stdlib.h>
%}

%option noyywrap

%%
(line)[0-9]+ [0-9]+ [0-9]+ [0-9]+{ yylval.str = strdup(yytext); return LINE; }
(point)[0-9]+ [0-9]+       { yylval.str = strdup(yytext); return POINT; }
(circle)[0-9]+ [0-9]+ [0-9]+{ yylval.str = strdup(yytext); return CIRCLE; }
(rectangle)[0-9]+ [0-9]+ [0-9]+ [0-9]+{ yylval.str = strdup(yytext); return RECTANGLE; }
(set_color)[0-9]+ [0-9]+ [0-9]+ { yylval.str = strdup(yytext); return SET_COLOR; }
[ \t\n]				            ;
\;                              {return END_STATEMENT;}
.                               {return ERROR;}

%%
