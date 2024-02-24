/* Compiler Theory and Design
   John Sommers
   November 14, 2023
*/

%{

#include <string>

using namespace std;

#include "listing.h"

int yylex();
void yyerror(const char* message);

%}

%define parse.error verbose

%token ADDOP MULOP ANDOP RELOP
%token BEGIN_ BOOLEAN END ENDREDUCE
%token FUNCTION INTEGER IS REDUCE RETURNS IDENTIFIER INT_LITERAL ARROW CASE ELSE ENDCASE
%token ENDIF IF OTHERS REAL THEN WHEN OROP NOTOP EXPOP REAL_LITERAL BOOL_LITERAL REMOP

%%

function:	
	function_header optional_variables body ;
	
function_header:	
	FUNCTION IDENTIFIER optional_parameters RETURNS type ';' ;

optional_variables:
	optional_variable optional_variables |
	;

optional_variable:
	variable |
	error ';'
	;

optional_parameters:
	optional_parameters parameter_ |
	;
	
parameter_:
	parameter |
	error ';'
	;

parameter:
	IDENTIFIER ':' type |
	parameter ',' 
	;

variable:
	IDENTIFIER ':' type IS statement_ ;
	
type:
	INTEGER |
	REAL |
	BOOLEAN ;

body:
	BEGIN_ statement_ END ';' ;
    
statement_:
	statement ';' |
	error ';' ;
	
statement:
	expression |
	REDUCE operator reductions ENDREDUCE |
	IF expression THEN statement_ ELSE statement_ ENDIF |
	CASE expression IS cases_ OTHERS ARROW statement_ ENDCASE;
	
operator:
	OROP |
	ADDOP |
	MULOP |
	REMOP |
	EXPOP;

reductions:
	reductions statement_ |
	;
cases_:
	cases |
	error ';' ;

cases:
	cases WHEN INT_LITERAL ARROW statement_ |
	;

		    
expression:
	expression OROP andoptest |
	andoptest ;
	
andoptest:
	andoptest ANDOP relation |
	relation;

relation:
	relation RELOP term |
	term;

term:
	term ADDOP factor |
	factor ;
      
factor:
	factor MULOP exptest |
	factor REMOP exptest |
	exptest ;
	
exptest:
	primary EXPOP exptest |
	primary;

primary:
	'(' expression ')' |
	NOTOP primary |
	INT_LITERAL | 
	REAL_LITERAL |
	BOOL_LITERAL |
	IDENTIFIER ;
  
%%

void yyerror(const char* message)
{
	appendError(SYNTAX, message);
}

int main(int argc, char *argv[])    
{
	firstLine();
	yyparse();
	lastLine();
	return 0;
} 
