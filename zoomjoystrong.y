%{
	#include <stdio.h>
	void yyerror(const char* msg);
	int yylex();
	int num_contacts = 0;
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
drawing: point|line|circle|rectangle|set_color
;
point: POINT INT INT INT
{zoomjoystrong::point($2,$3,$4);}
;
line:LINE INT INT INT INT
{zoomjoystrong::line($2,$3,$4,$5);}
;
circle: CIRCLE INT INT INT
{zoomjoystrong::circle($2,$3,$4);}
;
rectangle:RECTANGLE INT INT INT INT
{zoomjoystrong::rectangle($2,$3,$4,$5);}
;
set_color: SET_COLOR INT INT INT
{zoomjoystrong::set_color($2,$3,$4);}
;
int main(int argc, char** argv){
	yyparse();

	return 0;
}
void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
}
