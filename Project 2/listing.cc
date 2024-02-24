// Compiler Theory and Design
// John Sommers
// October 31, 2023

// This file contains the bodies of the functions that produces the compilation
// listing

#include <cstdio>
#include <string>
#include <iostream>
#include <vector>

using namespace std;

#include "listing.h"

static int lineNumber;
static string error = "";
static int totalErrors = 0;
static int lexicalErrors = 0;
static int syntacticErrors = 0;
static int semanticErrors = 0;
static std::vector<std::string> errorMessages;

static void displayErrors();

void firstLine()
{
	lineNumber = 1;
	printf("\n%4d  ",lineNumber);
}

void nextLine()
{
	displayErrors();
	lineNumber++;
	printf("%4d  ",lineNumber);
}

int lastLine()
{
	printf("\r");
	displayErrors();
	printf("     \n");
	if (totalErrors > 0) std::cout << "Lexical Errors: " << lexicalErrors << "\nSyntactic Errors: " << syntacticErrors << "\nSemantic Errors: " << semanticErrors << std::endl;
	else std::cout << "Compiled Successful" << std::endl;	
return totalErrors;
}
    
void appendError(ErrorCategories errorCategory, string message)
{
	string messages[] = { "Lexical Error, Invalid Character ", "",
		"Semantic Error, ", "Semantic Error, Duplicate Identifier: ",
		"Semantic Error, Undeclared " };

	error = messages[errorCategory] + message;
	if (errorCategory == 0 ){
		lexicalErrors++;
	}
	else if (errorCategory == 4 || errorCategory == 5) {
		semanticErrors++;
	}
	else if(errorCategory == 1 || errorCategory == 2) {
		syntacticErrors++;
	}
	totalErrors++;
	errorMessages.push_back(error);
}

void displayErrors()
{
    if (!errorMessages.empty()) {
		for (const std::string& errorMsg : errorMessages) {
			std::cout << errorMsg << std::endl;
		}    
	}
	errorMessages.clear();
}
