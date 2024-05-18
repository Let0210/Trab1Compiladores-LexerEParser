grammar gramaticaSimpAlg;

//regras léxicas (tokens)
START_PROG: 'begin';
END_PROG: 'end.';
TYPE_INT: 'int';
TYPE_FLOAT: 'float';
TYPE_VAR: 'var';
THEN: 'then';
IF: 'if';
ELSE: 'else';
ENDIF: 'endif';
END_CMD: ';';
NUM: [0-9]+ ;
VAR_NAME: ([a-z] | [A-Z]) ([a-z] | [A-Z] | NUM)*;

//comentários e espaços em branco
COMMENT: '{' .*? '}' -> skip;
WS     : [ \t\r\n]+ -> skip ;

//regras sintáticas
prog: START_PROG code END_PROG;
code: decl_var | decl_if | decl_atrib | print | COMMENT;
decl_var: (TYPE_VAR VAR_NAME (',' VAR_NAME)* ':' (TYPE_INT | TYPE_FLOAT)) END_CMD;
decl_if: (IF '(' exp_bool ')' THEN code | IF '(' exp_bool ')' THEN code ELSE code) ENDIF;
exp_bool:;
decl_atrib:;
print:;
