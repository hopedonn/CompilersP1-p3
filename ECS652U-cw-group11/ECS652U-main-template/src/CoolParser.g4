/**
 * Define a grammar for Cool
 */
parser grammar CoolParser;

options { tokenVocab = CoolLexer; }


/*  Starting point for parsing a Cool file  */

program 
	: (coolClass SEMICOLON)+ EOF
	;

coolClass : CLASSID (INHERITS CLASSID)? CURLY_OPEN (feature	SEMICOLON)* CURLY_CLOSE SEMICOLON    
	;

feature   : ID PARENT_OPEN (parameter (COMMA parameter)*)? PARENT_CLOSE COLON TYPE CURLY_OPEN expr CURLY_CLOSE # function
          | ID COLON ID (ASSIGN expr )?
	;
parameter : ID COLON ID
	;