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
%token ERROR_INPUT

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
drawing: 	point END_STATEMENT
	|	line END_STATEMENT
	|	circle END_STATEMENT
	|	rectangle END_STATEMENT
	|	set_color END_STATEMENT
	|	bad
	|	bad END_STATEMENT
	;
point: POINT INT INT
	/*	height is 768 
		Width is 1024
	*/
	{	
		if($2 >= 0 && $2 <= 1024 && $3 >= 0 && $3 <= 768 ){
			point($2,$3);/* printf("\npoint found\n");*/
		}
	}
	;
line:LINE INT INT INT INT
	{
		if($2 >= 0 && $2 <= 1024 && $3 >= 0 && $3 <= 768 && $4 >= 0 && $4 <=1024 && $5 >= 0 && $5 <= 768 ){
			line($2,$3,$4,$5);/* printf("\nline found with points %d %d %d %d\n", $2, $3, $4, $5);*/
		}
		else{
			printf("your line went off the screen! Height must be between 0-768 while height must be between 0-1024. Your values were %d %d %d %d", $2, $3, $4, $5);
		}
	}
	;
circle: CIRCLE INT INT INT
	{
		if($2 + $4 <= 1024 && $2 - $4 >= 0 && $3 + $4 <= 768 && $3 - $4 >= 0 ){
			circle($2,$3,$4);
		}
		else{
			printf("Your circle was out of bounds! Circle edges must be within the screen. Total Values must be between 0 and 1024 for width and between 0 and 768 for height. Your values were %d %d %d %d ", $2 + $4, $2 - $4, $3 + $4, $3 - $4);
		}
	}
	;
rectangle:RECTANGLE INT INT INT INT
	{

		if($2 >= 0 && $2 + $4 <= 1024 && $3 >= 0 && $3 + $5 <= 768){
			rectangle($2,$3,$4,$5);
		}
		else{
			printf("Your rectangle was out of bounds! Rectangle edges must be within the screen. Total Values must be between 0 and 1024 for width and between 0 and 768 for height. Your values were %d %d %d %d", $2, $3, $2 + $4, $3 + $5);
		}
	}
	;
set_color: SET_COLOR INT INT INT
	{
		if($2 > 255 || $2 < 0 || $3 > 255 || $3 < 0 || $4 > 255 || $4 < 0){
			printf("Error, colors must be within the 0-255 inclusive range. Your values were %d %d %d", $2, $3, $4);
		}
		else{


			set_color($2,$3,$4);
		}
	}
	;
bad: ERROR_INPUT
	{
		printf("You provided an unparseable command. Please retry.");
	}
	;
%%
int main(int argc, char** argv){
	setup();
	yyparse();
	finish();
	return 0;
}
void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
}
