/* Compiler Theory and Design
   John Sommers
   November 14, 2023
*/

/* This file contains flex input file */

%{
#include <cstdio>
#include <string>

using namespace std;

#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws		[ \t\r]+
comment		^(\/\/|--).*\n
line		[\n]
id		[A-Za-z][A-Za-z0-9]*(_[A-Za-z0-9]+)*
digit		[0-9]
int		{digit}+
punc		[\(\),:;]
relop		(=|\/=|>=|<=|>|<)
addop		[-+]
mulop		[\/*]
reallit		{digit}+\.{digit}*(?:[eE][-+]?{digit}+)?
boollit		(?:tru|fals)e
%%

{ws}		{ ECHO; }
{comment}	{ ECHO; nextLine();}
{line}		{ ECHO; nextLine();}
{relop}		{ ECHO; return(RELOP); }
{addop}		{ ECHO; return(ADDOP); }
{mulop}		{ ECHO; return(MULOP); }
begin		{ ECHO; return(BEGIN_); }
boolean		{ ECHO; return(BOOLEAN); }
end		{ ECHO; return(END); }
endreduce	{ ECHO; return(ENDREDUCE); }
function	{ ECHO; return(FUNCTION); }
integer		{ ECHO; return(INTEGER); }
is		{ ECHO; return(IS); }
reduce		{ ECHO; return REDUCE; }
returns		{ ECHO; return(RETURNS); }
and		{ ECHO; return(ANDOP); }
"=>"		{ ECHO; return(ARROW); }
"case"		{ ECHO; return(CASE); }
"else"		{ ECHO; return(ELSE); }
"endcase"	{ ECHO; return(ENDCASE); }
"endif"		{ ECHO; return(ENDIF); }
"if"		{ ECHO; return(IF); }
"others"	{ ECHO; return(OTHERS); }
"real"		{ ECHO; return(REAL); }
"then"		{ ECHO; return(THEN); }
"when"		{ ECHO; return(WHEN); }
"or"		{ ECHO; return(OROP); }
"not"		{ ECHO; return(NOTOP); }
"rem"		{ ECHO; return(REMOP); }
"**"		{ ECHO; return(EXPOP); }
{reallit}	{ ECHO; return(REAL_LITERAL); }
{boollit}	{ ECHO; return(BOOL_LITERAL); }
{id}		{ ECHO; return(IDENTIFIER); }
{int}		{ ECHO; return(INT_LITERAL); }
{punc}		{ ECHO; return(yytext[0]); }
.		{ ECHO; appendError(LEXICAL, yytext); }
%%

