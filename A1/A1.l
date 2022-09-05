%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>
	#include <stdbool.h>
	#include <assert.h>
	#include "A1.tab.h"
	void yyerror(char*); 
    int yyparse(void); 
%}

%%    
"//".*		;
"class"     {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return CLASS;}
"public"    {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return PUBLIC;}
"static"    {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext);return STATIC;}
"void"      {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return VOID;}
"main"      {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return MAIN;}
"String"    {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return STRING;}
"System.out.println" 	{yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return OUTPUT;}
"extends"   {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return EXTENDS;}
"return"	{yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return RETURN;}
"int"		{yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return INT;}
"boolean"	{yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return BOOLEAN;}
"if"		{yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return IF;}
"else"		{yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return ELSE;}
"while"		{yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return WHILE;}
".length"   {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return LENGTH;}
"true"      {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return TRE;}
"false" 	{yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return FLSE;}
"this"		{yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return THIS;}
"new"		{yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return NEW;}
"#defineExpr"  {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return DEFINE;}
"#defineExpr0"  {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return DEFINE;}
"#defineExpr1"  {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return DEFINE;}
"#defineExpr2"  {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return DEFINE;}
"#defineStmt"  {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return DEFINE;}
"#defineStmt0"  {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return DEFINE;}
"#defineStmt1"  {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return DEFINE;}
"#defineStmt2"  {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return DEFINE;}
"{"         {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return LEFTCURLBRACKET;}
"}"         {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return RIGHTCURLBRACKET;}
"("         {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return LEFTBRACKET;}
")"         {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return RIGHTBRACKET;}
"["	        {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return LEFTSQUAREBRACKET;}
"]"         {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return RIGHTSQUAREBRACKET;}
"="			{yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return EQUAL;}
"/"			{yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return DIVISION;}
"*"			{yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return MULTIPLICATION;}
"+" 		{yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return ADDITION;}
"-"			{yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return SUBTRACTION;}
";"			{yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return SEMICOLON;}
","			{yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return COMMA;}
"!"         {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return NOT;}
"."         {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return DOT;}
"&&"		{yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return AND;}
"||"		{yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return OR;}		
"!="		{yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return NOTEQ;}
"<="		{yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return LEQ;}
[A-Z|a-z]([A-Z|a-z]|[0-9]|[_])* {yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return IDENTIFIER;}
[0-9]+	 	{yylval.text = (char*)malloc(strlen(yytext)+1);strcpy(yylval.text,yytext); return INTEGER;}
[ \t\n]+	;
<<EOF>>     {return 0;};
.     		;
%%


void yyerror(char* str) { printf("//Failed to parse input code"); }

int yywrap(void) { return 1; }

int main(void) {
	yyparse();	
}
