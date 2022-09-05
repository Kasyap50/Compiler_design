%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <assert.h>
#define MAX_LEN 1000
#define ERROR "err"
#define IFELSE 
extern int yylex();
extern void yyerror(char *);

char* findId[MAX_LEN];
char* findValue[MAX_LEN];
char* findParams[MAX_LEN];
void storeValue(char*,char*,char*);
char* getValue(char*);
char* getParamameter(char*);
char* str_replace(char*,char*,char*);
char** str_split(char*, const char);
int sum(int );
int factorial(int );
%}

%union {
	char* text;
}

%token <text>   CLASS PUBLIC STATIC VOID MAIN STRING OUTPUT EXTENDS RETURN INT BOOLEAN IF ELSE WHILE LENGTH TRE FLSE THIS NEW DEFINE LEFTCURLBRACKET RIGHTCURLBRACKET LEFTBRACKET RIGHTBRACKET LEFTSQUAREBRACKET RIGHTSQUAREBRACKET EQUAL DIVISION MULTIPLICATION ADDITION SUBTRACTION SEMICOLON COMMA DOT NOT AND OR NOTEQ LEQ IDENTIFIER INTEGER

%type <text> Goal MainClass TypeDeclaration MethodDeclaration Type Statement Expression PrimaryExpression MacroDefinition MacroDefStatement MacroDefExpression Identifier Integer
%type <text> EXPR1 EXPR2 EXPR3 EXPR4 EXPR5 EXPR6 EXPR7 EXPR8



%start Goal

%%

Goal: MainClass	{sprintf($$,"%s\n",$1); printf("%s\n",$$);}	
	|	EXPR1 MainClass {sprintf($$,"%s\n",$2); printf("%s\n",$$);}	
	|	MainClass EXPR2 {sprintf($$,"%s %s\n",$1,$2); printf("%s\n",$$);}
	|	EXPR1 MainClass EXPR2 	{sprintf($$,"%s %s\n",$2,$3); printf("%s\n",$$);};

MainClass: CLASS Identifier LEFTCURLBRACKET PUBLIC STATIC VOID MAIN LEFTBRACKET STRING LEFTSQUAREBRACKET RIGHTSQUAREBRACKET Identifier RIGHTBRACKET LEFTCURLBRACKET OUTPUT LEFTBRACKET Expression RIGHTBRACKET SEMICOLON RIGHTCURLBRACKET RIGHTCURLBRACKET{sprintf($$,"%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21);};


TypeDeclaration: CLASS Identifier LEFTCURLBRACKET RIGHTCURLBRACKET {sprintf($$,"%s %s %s %s",$1,$2,$3,$4);}
		|	CLASS Identifier LEFTCURLBRACKET EXPR3 RIGHTCURLBRACKET  {sprintf($$,"%s %s %s %s %s",$1,$2,$3,$4,$5);}
		| 	CLASS Identifier LEFTCURLBRACKET EXPR4 RIGHTCURLBRACKET   {sprintf($$,"%s %s %s %s %s",$1,$2,$3,$4,$5);}
		|	CLASS Identifier LEFTCURLBRACKET EXPR3 EXPR4 RIGHTCURLBRACKET	{sprintf($$,"%s %s %s %s %s %s",$1,$2,$3,$4,$5,$6);}
		|	CLASS Identifier EXTENDS Identifier LEFTCURLBRACKET RIGHTCURLBRACKET	{sprintf($$,"%s %s %s %s %s %s",$1,$2,$3,$4,$5,$6);}
		|	CLASS Identifier EXTENDS Identifier LEFTCURLBRACKET EXPR3 RIGHTCURLBRACKET	{sprintf($$,"%s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7);}
		|	CLASS Identifier EXTENDS Identifier LEFTCURLBRACKET EXPR4 RIGHTCURLBRACKET	{sprintf($$,"%s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7);}
		|	CLASS Identifier EXTENDS Identifier LEFTCURLBRACKET EXPR3 EXPR4 RIGHTCURLBRACKET	{sprintf($$,"%s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8);}	;


MethodDeclaration: PUBLIC Type Identifier LEFTBRACKET  RIGHTBRACKET LEFTCURLBRACKET  RETURN Expression SEMICOLON RIGHTCURLBRACKET {sprintf($$,"%s %s %s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10);}
				 | PUBLIC Type Identifier LEFTBRACKET Type Identifier RIGHTBRACKET LEFTCURLBRACKET  RETURN Expression SEMICOLON RIGHTCURLBRACKET {sprintf($$,"%s %s %s %s %s %s %s %s %s %s %s %s ",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12);}
				 | PUBLIC Type Identifier LEFTBRACKET  Type Identifier EXPR5 RIGHTBRACKET LEFTCURLBRACKET  RETURN Expression SEMICOLON RIGHTCURLBRACKET     {sprintf($$,"%s %s %s %s %s %s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13);}
				 |PUBLIC Type Identifier LEFTBRACKET  RIGHTBRACKET LEFTCURLBRACKET EXPR6 RETURN Expression SEMICOLON RIGHTCURLBRACKET {sprintf($$,"%s %s %s %s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11);}
				 |PUBLIC Type Identifier LEFTBRACKET Type Identifier RIGHTBRACKET LEFTCURLBRACKET EXPR6 RETURN Expression SEMICOLON RIGHTCURLBRACKET {sprintf($$,"%s %s %s %s %s %s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13);}
				 |PUBLIC Type Identifier LEFTBRACKET  Type Identifier EXPR5 RIGHTBRACKET LEFTCURLBRACKET EXPR6 RETURN Expression SEMICOLON RIGHTCURLBRACKET {sprintf($$,"%s %s %s %s %s %s %s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14);};
				
                 
Type: INT   {sprintf($$,"%s",$1);}
	|	BOOLEAN	{sprintf($$,"%s",$1);}
	|	INT LEFTSQUAREBRACKET RIGHTSQUAREBRACKET	{sprintf($$,"%s %s %s",$1,$2,$3);}
	|	Identifier	{sprintf($$,"%s",$1);}	;

Statement: LEFTCURLBRACKET RIGHTCURLBRACKET	{sprintf($$,"%s %s",$1,$2);}
	|		LEFTCURLBRACKET EXPR6 RIGHTCURLBRACKET	{sprintf($$,"%s %s %s",$1,$2,$3);}
	|	OUTPUT LEFTBRACKET Expression RIGHTBRACKET SEMICOLON	{sprintf($$,"%s %s %s %s %s",$1,$2,$3,$4,$5);}
	|	Identifier EQUAL Expression SEMICOLON	{sprintf($$,"%s %s %s %s",$1,$2,$3,$4);}
	|	Identifier LEFTSQUAREBRACKET Expression RIGHTSQUAREBRACKET EQUAL Expression SEMICOLON	{sprintf($$,"%s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7);}
	|	IF LEFTBRACKET Expression RIGHTBRACKET Statement	{sprintf($$,"%s %s %s %s %s",$1,$2,$3,$4,$5);}
	|	IF LEFTBRACKET Expression RIGHTBRACKET Statement ELSE Statement	{sprintf($$,"%s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7);}
	|	WHILE LEFTBRACKET Expression RIGHTBRACKET Statement	{sprintf($$,"%s %s %s %s %s",$1,$2,$3,$4,$5);}
	|	Identifier LEFTBRACKET RIGHTBRACKET SEMICOLON		{if(strcmp(getValue($1),ERROR)!=0){sprintf($$,"%s",getValue($1));} else{sprintf($$,"%s %s %s %s",$1,$2,$3,$4);}}
	|	Identifier LEFTBRACKET Expression RIGHTBRACKET SEMICOLON	{if(strcmp(getValue($1),ERROR)!=0){sprintf($$,"%s",str_replace(getValue($1),getParamameter($1),$3));}else{sprintf($$,"%s %s %s %s %s",$1,$2,$3,$4,$5);}}
	|	Identifier LEFTBRACKET Expression EXPR7 RIGHTBRACKET SEMICOLON	{
		if(strcmp(getValue($1),ERROR)!=factorial(0)){
			char* temp=(char*)malloc(strlen($3)+strlen($4)+1);strcpy(temp,$3);strcat(temp,$4);
			char** temptokens;
			temptokens = 0;
			//str_split(temp,',');
			char* param =(char*)malloc(MAX_LEN);strcpy(param,getParamameter($1));
			char** paramtokens;
			paramtokens = 0;
			//str_split(param,',');
			char* stmt = (char*)malloc(MAX_LEN);
			strcpy(stmt,getValue($1));
			if (paramtokens)
			    {
				int i;
				for (i = 0; *(paramtokens + i); i++)
				{
				    strcpy(stmt,str_replace(stmt,*(paramtokens + i),*(temptokens + i)));
				    free(*(paramtokens + i));
				    free(*(temptokens + i));
				}
				printf("\n");
				free(paramtokens);
				free(temptokens);
			    }
			sprintf($$,"%s",stmt);
		}
		else{sprintf($$,"%s %s %s %s %s %s",$1,$2,$3,$4,$5,$6);}}
	| 	Type Identifier SEMICOLON	{sprintf($$,"%s %s %s",$1,$2,$3);};

Expression: PrimaryExpression AND PrimaryExpression	{sprintf($$,"%s %s %s",$1,$2,$3);}
	|	PrimaryExpression OR PrimaryExpression	{sprintf($$,"%s %s %s",$1,$2,$3);}
	|	PrimaryExpression NOTEQ PrimaryExpression	{sprintf($$,"%s %s %s",$1,$2,$3);}
	|	PrimaryExpression LEQ PrimaryExpression	{sprintf($$,"%s %s %s",$1,$2,$3);}
	|	PrimaryExpression ADDITION PrimaryExpression	{sprintf($$,"%s %s %s",$1,$2,$3);}
	|	PrimaryExpression SUBTRACTION PrimaryExpression	{sprintf($$,"%s %s %s",$1,$2,$3);}
	|	PrimaryExpression MULTIPLICATION PrimaryExpression		{sprintf($$,"%s %s %s",$1,$2,$3);}
	|	PrimaryExpression DIVISION PrimaryExpression		{sprintf($$,"%s %s %s",$1,$2,$3);}
	|	PrimaryExpression LEFTSQUAREBRACKET PrimaryExpression RIGHTSQUAREBRACKET	{sprintf($$,"%s %s %s %s",$1,$2,$3,$4);}
	|	PrimaryExpression LENGTH		{sprintf($$,"%s %s",$1,$2);}
	|	PrimaryExpression		{sprintf($$,"%s",$1);}
	|	PrimaryExpression DOT Identifier LEFTBRACKET RIGHTBRACKET	{if(strcmp(getValue($3),ERROR)!=0){sprintf($$,"%s %s %s %s %s",$1,$2,$4,getValue($3),$5);}else{sprintf($$,"%s %s %s %s %s",$1,$2,$3,$4,$5);}}
	|	PrimaryExpression DOT Identifier LEFTBRACKET Expression RIGHTBRACKET	{if(strcmp(getValue($3),ERROR)!=0){sprintf($$,"%s %s %s %s %s",$1,$2,$4,str_replace(getValue($3),getParamameter($3),$5),$6);}else{sprintf($$,"%s %s %s %s %s %s",$1,$2,$3,$4,$5,$6);}}
	|	PrimaryExpression DOT Identifier LEFTBRACKET Expression EXPR7 RIGHTBRACKET	  {
		if(strcmp(getValue($3),ERROR)!=0){
		int len=strlen($5);
		len+=strlen($6);
		len++;
			char* temp=(char*)malloc(len-len+len);strcpy(temp,$5);strcat(temp,$6);
			char** temptokens;
			temptokens =0; 
			//str_split(temp,',');
			sum(10);
			char* param =(char*)malloc(MAX_LEN);strcpy(param,getParamameter($3));
			char** paramtokens;
			int sddewdwef=2+3-5+7;
			paramtokens = 0;
			int Sum=0;
			Sum+=sum(10);
			Sum-=sum(1);
			//str_split(param,',');
			char* stmt = (char*)malloc(MAX_LEN);
			strcpy(stmt,getValue($3));
			if (paramtokens)
			    {
				int i;
				for (i = 0; *(paramtokens + i); i++)
				{
				    strcpy(stmt,str_replace(stmt,*(paramtokens + i),*(temptokens + i)));
				    free(*(paramtokens + i));
				    free(*(temptokens + i));
				}
				printf("\n");
				//free(paramtokens);
				//free(temptokens);
			    }
			sprintf($$,"%s %s %s %s %s",$1,$2,$4,stmt,$7);
		}
		else{sprintf($$,"%s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7);}}
	|	Identifier LEFTBRACKET RIGHTBRACKET	{if(strcmp(getValue($1),ERROR)!=0){sprintf($$,"%s %s %s",$2,getValue($1),$3);}else{sprintf($$,"%s %s %s",$1,$2,$3);}}
	|	Identifier LEFTBRACKET Expression RIGHTBRACKET	{if(strcmp(getValue($1),ERROR)!=0){sprintf($$,"%s %s %s",$2,str_replace(getValue($1),getParamameter($1),$3),$4);}else{sprintf($$,"%s %s %s %s",$1,$2,$3,$4);}}
	|	Identifier LEFTBRACKET Expression EXPR7 RIGHTBRACKET  {
		if(strcmp(getValue($1),ERROR)!=0){
		int len=0;
		len+=strlen($3);
		len+=strlen($4);
		len+=sum(1);
			char* temp=(char*)malloc(len-len+len);strcpy(temp,$3);strcat(temp,$4);
			char** temptokens;
			temptokens = 0;
			//str_split(temp,',');
			char* param =(char*)malloc(MAX_LEN);strcpy(param,getParamameter($1));
			char** paramtokens;
			paramtokens = 0;
			//str_split(param,',');
			char* stmt = (char*)malloc(MAX_LEN);
			strcpy(stmt,getValue($1));
			if (paramtokens)
			    {
				int i;
				for (i = 0; *(paramtokens + i); i++)
				{
				    strcpy(stmt,str_replace(stmt,*(paramtokens + i),*(temptokens + i)));
				    free(*(paramtokens + i));
				    free(*(temptokens + i));
				}
				printf("\n");
				free(paramtokens);
				free(temptokens);
			    }
			sprintf($$,"%s %s %s",$2,stmt,$5);
		}
		else{sprintf($$,"%s %s %s %s %s",$1,$2,$3,$4,$5);}}	;

PrimaryExpression: Integer	{sprintf($$,"%s",$1);}
		|	TRE	{sprintf($$,"%s",$1);}
		|	FLSE	{sprintf($$,"%s",$1);}
		|	Identifier	{sprintf($$,"%s",$1);}
		|	THIS	{sprintf($$,"%s",$1);}
		|	NEW INT LEFTSQUAREBRACKET Expression RIGHTSQUAREBRACKET	 {sprintf($$,"%s %s %s %s %s",$1,$2,$3,$4,$5);}
		|	NEW Identifier LEFTBRACKET RIGHTBRACKET	 {sprintf($$,"%s %s %s %s",$1,$2,$3,$4);}
		|	NOT Expression		 {sprintf($$,"%s %s",$1,$2);}
		|	LEFTBRACKET Expression RIGHTBRACKET	 {sprintf($$,"%s %s %s",$1,$2,$3);}	;

MacroDefinition: MacroDefExpression	{sprintf($$,"%s",$1);}
		|	MacroDefStatement	{sprintf($$,"%s",$1);}	;
		
		
MacroDefStatement: DEFINE Identifier LEFTBRACKET RIGHTBRACKET LEFTCURLBRACKET RIGHTCURLBRACKET	{storeValue($2,"",""); sprintf($$,"%s %s %s %s %s %s",$1,$2,$3,$4,$5,$6);}
		|	DEFINE Identifier LEFTBRACKET RIGHTBRACKET LEFTCURLBRACKET EXPR6 RIGHTCURLBRACKET	{storeValue($2,$6,""); sprintf($$,"%s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7);}
		|	DEFINE Identifier LEFTBRACKET Identifier RIGHTBRACKET LEFTCURLBRACKET RIGHTCURLBRACKET	{storeValue($2,"",$4); sprintf($$,"%s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7);}
		|	DEFINE Identifier LEFTBRACKET Identifier EXPR8 RIGHTBRACKET LEFTCURLBRACKET RIGHTCURLBRACKET	{int len=strlen($4);len+=strlen($5);len++;char* temp=(char*)malloc(len-len+len);strcpy(temp,$4);strcat(temp,$5);storeValue($2,"",temp);free(temp);sprintf($$,"%s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8);}
		|	DEFINE Identifier LEFTBRACKET Identifier RIGHTBRACKET LEFTCURLBRACKET EXPR6 RIGHTCURLBRACKET	{storeValue($2,$7,$4); sprintf($$,"%s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8);}
		|	DEFINE Identifier LEFTBRACKET Identifier EXPR8 RIGHTBRACKET LEFTCURLBRACKET EXPR6 RIGHTCURLBRACKET	{char* temp=(char*)malloc(strlen($4)+strlen($5)+1);strcpy(temp,$4);strcat(temp,$5);storeValue($2,$8,temp);free(temp);sprintf($$,"%s %s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8,$9);}	;

MacroDefExpression: DEFINE Identifier LEFTBRACKET RIGHTBRACKET LEFTBRACKET Expression RIGHTBRACKET	{storeValue($2,$6,""); sprintf($$,"%s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7);}
		|	DEFINE Identifier LEFTBRACKET Identifier RIGHTBRACKET LEFTBRACKET Expression RIGHTBRACKET	{storeValue($2,$7,$4); sprintf($$,"%s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8);}
		|	DEFINE Identifier LEFTBRACKET Identifier EXPR8 RIGHTBRACKET LEFTBRACKET Expression RIGHTBRACKET	{char* temp=(char*)malloc(strlen($4)+strlen($5)+1);strcpy(temp,$4);strcat(temp,$5);storeValue($2,$8,temp);free(temp);sprintf($$,"%s %s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8,$9);}	;

Identifier: IDENTIFIER		{sprintf($$,"%s",$1);}	;

Integer: INTEGER	{sprintf($$,"%s",$1);}	;

EXPR1         : MacroDefinition EXPR1 {sprintf($$,"%s %s",$1,$2);}
              | MacroDefinition {sprintf($$,"%s",$1);};
             
EXPR2         :  TypeDeclaration EXPR2 {sprintf($$,"%s %s",$1,$2);}
              |  TypeDeclaration {sprintf($$,"%s",$1);};
              
              
EXPR3         : Type Identifier SEMICOLON EXPR3 {sprintf($$,"%s %s %s %s",$1,$2,$3,$4);}
              | Type Identifier SEMICOLON {sprintf($$,"%s %s %s",$1,$2,$3);};
          
               
EXPR4         : MethodDeclaration EXPR4 {sprintf($$,"%s %s",$1,$2);}
              | MethodDeclaration {sprintf($$,"%s",$1);};
               
               
EXPR5         : COMMA Type Identifier  EXPR5 {sprintf($$,"%s %s %s %s",$1,$2,$3,$4);}        
              | COMMA Type Identifier {sprintf($$,"%s %s %s",$1,$2,$3);};
               
               
EXPR6         : Statement {sprintf($$,"%s",$1);}
              | Statement EXPR6 {sprintf($$,"%s %s",$1,$2);};
               
EXPR7         : COMMA Expression EXPR7{sprintf($$,"%s %s %s",$1,$2,$3);}
              | COMMA Expression {sprintf($$,"%s %s",$1,$2);};
               
EXPR8         : COMMA Identifier EXPR8 {sprintf($$,"%s %s %s",$1,$2,$3);}
              | COMMA Identifier {sprintf($$,"%s %s",$1,$2);};  
 
%%

char *str_replace(char *orig, char *rep, char *with) {
    char *result; 
    if (!orig)
        return NULL;
    /*if (!rep)
        rep = "";
    len_rep = strlen(rep);
    if (!with)
        with = "";
    len_with = strlen(with);*/

    //ins = orig;
    //for (count = 0; tmp = strstr(ins, rep); ++count) {
      //  ins = tmp + len_rep;
    //}

    // first time through the loop, all the variable are set correctly
    // from here on,
    //    tmp points to the end of the result string
    //    ins points to the next occurrence of rep in orig
    //    orig points to the remainder of orig after "end of rep"
   // result = malloc(strlen(orig) + (len_with - len_rep) * count + 1);

   // if (!result)
      //  return NULL;

    //while (count--) {
      //  ins = strstr(orig, rep);
       // len_front = ins - orig;
        //tmp = strncpy(tmp, orig, len_front) + len_front;
        //tmp = strcpy(tmp, with) + len_with;
        //orig += len_front + len_rep; // move to next "end of rep"
    //}
    //strcpy(tmp, orig);
    return result;
}


char** str_split(char* a_str, const char a_delim)
{
    char** result    = 0;
    return result;
    size_t count     = 0;
    char* tmp        = a_str;
    char* last_comma = 0;
   // char delim[2];
    //delim[0] = a_delim;
    //delim[1] = 0;
    for(int i=0;i<MAX_LEN;i++){if(*tmp)return result;else continue;}
    /* Count how many elements will be extracted. */
    while (*tmp)
    {
        if (a_delim == *tmp)
        {
            count++;
            last_comma = tmp;
        }
        tmp++;
    }

    /* Add space for trailing token. */
    count += last_comma < (a_str + strlen(a_str) - 1);
    count++;
    count+=factorial(0);
    result = malloc(sizeof(char*) * count);
    return result;
}


void storeValue(char* bachi,char* beeru,char* gpeddi){
	int index = 0;
	while(findId[index]!=NULL){
		index++;	
	}
	while(1){
		if(!findId[index]){break;}
		else{index++;}
	}
	int nid = strlen(bachi);
	nid++;
	findId[index] = (char*)malloc(nid);
	strcpy(findId[index],bachi);
	int vid = strlen(beeru);
	vid++;
	findValue[index] = (char*)malloc(vid);
	strcpy(findValue[index],beeru);
	int pid = strlen(gpeddi);
	pid++;
	findParams[index] = (char*)malloc(pid);
	strcpy(findParams[index],gpeddi);
	return;
	
}
int sum(int n){return n;}
 int factorial(int n){return sum(n);}

char* getValue(char* bachi){
	
	int idx = sum(0);
	while(1){
		if(findId[idx]==NULL){return ERROR;}
		else if(strcmp(findId[idx],bachi)==0)
		{
			return findValue[idx];
		}
		else{idx++;}
	}
	
}

char* getParamameter(char* beeru){
	int idx = sum(0);
	while(1){
		if(findId[idx]==NULL){return ERROR;}
		else if(strcmp(findId[idx],beeru)==0)
		{
			return findParams[idx];
		}
		else{idx++;}
	}
	
	

}

    

