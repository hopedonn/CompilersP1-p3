/**
 * Define a lexer rules for Cool
 */
lexer grammar CoolLexer;

/* Punctution */

PERIOD              : '.';
COMMA               : ',';
AT                  : '@';
SEMICOLON           : ';';
COLON               : ':';

CURLY_OPEN          : '{' ;
CURLY_CLOSE         : '}' ;
PARENT_OPEN         : '(' ;
PARENT_CLOSE        : ')' ;

/* Operators */
PLUS_OPERATOR       : '+';
MINUS_OPERATOR      : '-';
MULT_OPERATOR       : '*';
DIV_OPERATOR        : '/';

INT_COMPLEMENT_OPERATOR     : '~';

LESS_OPERATOR               : '<';
LESS_EQ_OPERATOR            : '<=';
EQ_OPERATOR                 : '=' ;
ASSIGN_OPERATOR 	        : '<-';
RIGHTARROW                  : '=>';

/*added here */

INT                     : [0-9]+;
CLASS                   : [cC] [lL] [aA] [sS] [sS];
INHERITS                : [iI] [nN] [hH] [eE] [rR] [iI] [tT] [sS];
NEW                     : [nN] [eE] [wW];
NOT                     : [nN] [oO] [tT];
TRUE                    : [tT] [rR] [uU] [eE];
FALSE                   : [fF] [aA] [lL] [sS] [eE];
IF                      : [iI] [fF];
THEN                    : [tT] [hH] [eE] [nN];
ELSE                    : [eE] [lL] [sS] [eE];
FI                      : [fF] [iI];
WHILE                   : [wW] [hH] [iI] [lL] [eE];
LOOP                    : [lL] [oO] [oO] [pP];
POOL                    : [pP] [oO] [oO] [lL];
CASE                    : [cC] [aA] [sS] [eE];
OF                      : [oO] [fF];
ESAC                    : [eE] [sS] [aA] [cC];
LET                     : [lL] [eE] [tT];
IN                      : [iI] [nN];
ISVOID                  : [Ii][sS][vV] [oO] [iI] [dD];
ID                      : [a-z_][a-zA-Z0-9_]*;
STRING                  : '"' (('\\'|'\t'|'\r\n'|'\r'|'\n'|'\\"') | ~('\\'|'\t'|'\r'|'\n'|'"'))* '"';
WHITESPACE              : [ \n\t\r]+ -> skip;
CLASSID                 : [A-Z][a-zA-Z_0-9]*;
COMMENT                 : '--' ~[\r\n]* -> skip;










ERROR : . ;
