%{
	#include <stdio.h>
	#include "zoomjoystrong.h"
	void yyerror(const char* msg);
	int yylex();
	
%}

%error-verbose
%start drawing_list
%union { int i; char* str; float f;}

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT
%token STRING

%type<i> INT
%type<f> FLOAT
%type<str> POINT
%type<str> LINE
%type<str> CIRCLE
%type<str> RECTANGLE
%type<str> SET_COLOR
%type<str> STRING
%%
drawing_list:	drawing
	|	drawing drawing_list

;
drawing: point END_STATEMENT|line END_STATEMENT|circle END_STATEMENT|rectangle END_STATEMENT|set_color END_STATEMENT
;
point: POINT INT INT
{point($2,$3);}
;
line:LINE INT INT INT INT
{line($2,$3,$4,$5);}
;
circle: CIRCLE INT INT INT
{circle($2,$3,$4);}
;
rectangle:RECTANGLE INT INT INT INT
{rectangle($2,$3,$4,$5);}
;
set_color: SET_COLOR INT INT INT
{set_color($2,$3,$4);}
;

%%
int main(int argc, char** argv){
	yyparse();

	return 0;
}
void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
}
