%option noyywrap

%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	int lineno = 1; // initialize to 1
	void ret_print(char *token_type);
	void yyerror();
%}

harf 	    	[a-zA-Z]
sayi 		    [0-9]
harfSayi 	    {harf}|{sayi}
ID 			    {harf}+{harfSayi}*
TAMSAYISABIT	"0"|[0-9]{sayi}*

%%

"tamsayi"   			{ ret_print("TAMSAYI"); }
"eger"  				{ ret_print("EGER"); }
"ise"       			{ ret_print("ISE"); }
"degilse"   			{ ret_print("DEGILSE"); }

"-" 					{ ret_print("CIKARMA"); }

":"				        { ret_print("BLOKBASI"); }
"="				        { ret_print("ATAMA"); }
"("				        { ret_print("PARANTEZAC"); }
")"				        { ret_print("PARANTEZKAPAT"); }
"<"				        { ret_print("KUCUKTUR"); }

{ID} 			        { ret_print("ID"); }
{TAMSAYISABIT} 		    { ret_print("TAMSAYISABIT"); }


"\n"			        { lineno += 1; }
[ \t\r\f]+			    /* eat up whitespace */

.				{ yyerror("Unrecognized character"); }

%%

void ret_print(char *token_type){
	printf("yytext: %s\ttoken: %s\tlineno: %d\n", yytext, token_type, lineno);
}

void yyerror(char *message){
	printf("Error: \"%s\" in line %d. Token = %s\n", message, lineno, yytext);
	exit(1);
}

int main(int argc, char *argv[]){
	yyin = fopen(argv[1], "r");
	yylex();
	fclose(yyin);
	return 0;
}