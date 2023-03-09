/**
 * Define a grammar for Cool
 */
parser grammar CoolParser;

options { tokenVocab = CoolLexer; }


/*  Starting point for parsing a Cool file  */

program 
	: (coolClass SEMICOLON)+ EOF
	;

coolClass :CLASS TYPE_ID (INHERITS TYPE_ID)?
           CURLY_OPEN (feature SEMICOLON)* CURLY_CLOSE
	;

feature
   : OBJECT_ID PARENT_OPEN (formal (COMMA formal)*)* PARENT_CLOSE COLON TYPE_ID CURLY_OPEN expression CURLY_CLOSE
   | OBJECT_ID COLON TYPE_ID (ASSIGN_OPERATOR expression)?;

formal
   : OBJECT_ID COLON TYPE_ID
   ;

/* method argument */
expression
   : OBJECT_ID ASSIGN_OPERATOR expression
   |expression (AT TYPE_ID)? PERIOD OBJECT_ID PARENT_OPEN (expression (COMMA expression)*)* PARENT_CLOSE
   | OBJECT_ID PARENT_OPEN (expression (COMMA expression)*)* PARENT_CLOSE
   | IF expression THEN expression ELSE expression FI
   | WHILE expression LOOP expression POOL
   | CURLY_OPEN (expression SEMICOLON) + CURLY_CLOSE
   | LET OBJECT_ID COLON TYPE_ID (ASSIGN_OPERATOR expression)? (COMMA OBJECT_ID COLON TYPE_ID (ASSIGN_OPERATOR expression)?)* IN expression
   | CASE expression OF (OBJECT_ID COLON TYPE_ID RIGHTARROW expression SEMICOLON) + ESAC
   | NEW TYPE_ID
   | ISVOID expression
   | expression MULT_OPERATOR expression
   | expression DIV_OPERATOR expression
   | expression PLUS_OPERATOR expression
   | expression MINUS_OPERATOR expression
   | INT_COMPLEMENT_OPERATOR expression
   | expression LESS_OPERATOR expression
   | expression LESS_EQ_OPERATOR expression
   | expression EQ_OPERATOR expression
   | expression GREATER_OPERATOR expression
   | NOT expression
   | PARENT_OPEN expression PARENT_CLOSE

   | OBJECT_ID
   | INT
   | STRING
   | TRUE
   | FALSE
   | OBJECT_ID ASSIGN_OPERATOR expression

   ;


