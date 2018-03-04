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
point: STRING INT INT INT
;
line:STRING INT INT INT INT
;
circle: STRING INT INT INT
;
rectangle:STRING INT INT INT INT
;
set_color: STRING INT INT INT
;
int main(int argc, char** argv){
	yyparse();

	return 0;
}
void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
}
