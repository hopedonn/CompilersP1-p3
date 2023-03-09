lexer grammar CoolLexer;

@members{
public void reportError(String errorString) {
		setText(errorString);
		setType(ERROR);
	}

	public void notFound() {
		Token t = _factory.create(_tokenFactorySourcePair, _type, _text, _channel, _tokenStartCharIndex, getCharIndex()-1, _tokenStartLine, _tokenStartCharPositionInLine);
		String text = t.getText();
		reportError(text);
	}

	public void processString() {
		Token t = _factory.create(_tokenFactorySourcePair, _type, _text, _channel, _tokenStartCharIndex, getCharIndex()-1, _tokenStartLine, _tokenStartCharPositionInLine);
		String text = t.getText();
		StringBuilder buf = new StringBuilder(0);
		//write your code to test strings here
		for(int i = 0; i < text.length(); ++i) {
			if(text.charAt(i) == '\\') {
				if(text.charAt(i+1) == 'n')
					buf.append('\n');
				else if(text.charAt(i+1) == 'f')
					buf.append('\f');
				else if(text.charAt(i+1) == 't')
					buf.append('\t');
				else if(text.charAt(i+1) == 'b')
					buf.append('\t');
				else if(text.charAt(i+1) == '\"')
					buf.append('\"');
				else if(text.charAt(i+1) == '\\')
					buf.append('\\');
				else
					buf.append(text.charAt(i+1));
				i++;
			}
			else {
				buf.append(text.charAt(i));
			}
		}
		String ntext = buf.toString();
		if(ntext.length() > 1024) {
			reportError("String constant too long");
			return;
		}
		setText(ntext);
		return;
	}
}

/**
 * Define a lexer rules for Cool
 */


/* Punctution */

STRING	: '"'  (ESC|.)*? '"' { processString() ;} ;
fragment ESC: '\\"' | '\\\\' ;

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
GREATER_OPERATOR             : '>';
DoubleQout  : '"';

fragment A : [Aa];fragment B : [Bb];fragment C : [Cc];fragment D : [Dd];fragment E : [Ee];fragment F : [Ff];
fragment G : [Gg];fragment H : [Hh];fragment I : [Ii];fragment J : [Jj];fragment K : [Kk];fragment L : [Ll];
fragment M : [Mm];fragment N : [Nn];fragment O : [Oo];fragment P : [Pp];fragment Q : [Qq];fragment R : [Rr];
fragment S : [Ss];fragment T : [Tt];fragment U : [Uu];fragment V : [Vv];fragment W : [Ww];fragment X : [Xx];
fragment Y : [Yy];fragment Z : [Zz];

IF : I F ;
INHERITS : I N H E R I T S ;
CASE : C A S E ;
CLASS : C L A S S ;
FOR : F O R  ;
ELSE : E L S E ;
FI : F I ;
ESAC :  E S A C ;
FALSE : 'f'A L S E;
TRUE : 't' R U E;
IN : I N ;
ISVOID : I S V O I D ;
LET : L E T ;
LOOP : L O O P ;
POOL : P O O L ;
NOT : N O T ;
OF : O F ;
NEW : N E W ;
THEN : T H E N ;
WHILE : W H I L E ;



INT: DIGIT+ ;
fragment
DIGIT : [0-9];

TYPE_ID: [A-Z] IDENTIFIER*;

OBJECT_ID: [a-z] IDENTIFIER*;
IDENTIFIER:  LETTER| DIGIT| '_' | '['|']';


fragment
LETTER : [a-zA-Z];


WHITESPACE: (' '|'\n'|'\r'|'\t'| 'u000B')+-> skip;

ERROR : . ;

/* COMMENTS */
LINE_COMMENT: '--' .*? '\n' -> skip ;


END_COMMENT	: '*)' EOF { reportError("Unmatched *)"); } ;
UN_COMMENT 	: '*)' { reportError("Unmatched *)"); } ;

COMMENT		: '(*'-> pushMode(INCOMMENT), skip;

NOTFOUND	: . { notFound(); } ;


mode INCOMMENT;
ERR     	: .(EOF) { reportError("EOF in comment"); } ;
OCOMMENT	: '(*' -> pushMode(ININCOM), skip ;
CCOMMENT	: '*)' -> popMode, skip ;
INCOMMENT_T : . -> skip ;

mode ININCOM;
ERR3		: .(EOF) { reportError("EOF in comment"); } ;
OCOM		: '(*' -> pushMode(ININCOM), skip ;
ERR4		: '*)' EOF { reportError("EOF in comment"); } ; 
CCOM		: '*)' -> popMode, skip ;
INCOM_TEXT	: . -> skip ;

