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
AND: 'and';
OR: 'or';
END_CMD: ';';
NUM: [0-9]+ ;
VAR_NAME: [a-zA-Z] [a-zA-Z0-9]*; //-> sem caseSensitive fica assim: ([a-z] | [A-Z]) ([a-z] | [A-Z] | NUM)*


//comentários e espaços em branco
COMMENT: '{' .*? '}' -> skip;
WS     : [ \t\r\n]+ -> skip ;

//regras sintáticas (a gramática em si)
prog: START_PROG code END_PROG;
code: (command)+;
command: (decl_var | decl_if | decl_atrib | print | exp_arit); //não precisa colocar | COMMENT
decl_var: (TYPE_VAR VAR_NAME (',' VAR_NAME)* ':' (TYPE_INT | TYPE_FLOAT)) END_CMD;
decl_if: (IF '(' exp_bool ')' THEN (command)+ | IF '(' exp_bool ')' THEN (command)+ ELSE (command)+) ENDIF;
//exp_bool: ((exp_rela | exp_log) ((AND | OR) exp_bool)*) ;
exp_bool: exp_term ( (AND | OR) exp_term )*;
exp_term: '(' exp_bool ')' | exp_rela | exp_log;
exp_rela: VAR_NAME ('>' |'>=' | '<' | '<=' | '==' | '!=') VAR_NAME; //(VAR_NAME | exp_arit) ('>' |'>=' | '<' | '<=' | '==' | '!=') (VAR_NAME | exp_arit); ->se aceitasse expressões aritméticas tbm
exp_log: '!' VAR_NAME;
exp_arit: term (('+' | '-') term )*;
term: factor ( ('*' | '/' | '%') factor )*;
factor: NUM | VAR_NAME | '(' exp_arit ')';
decl_atrib: VAR_NAME ':=' exp_arit END_CMD;
print:'só para não ficar vazio e dar erro por enquanto';
