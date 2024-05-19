//1º trabalho de Compiladores - Analisador Léxico e Sintático da gramática SimpAlg
//Alunos: ANA LETICIA RODRIGUES DE OLIVEIRA E  ANTONIO GERALDO REGO JUNIOR

grammar gramaticaSimpAlg;

//regras léxicas (tokens)
START_PROG: 'begin';
END_PROG: 'end.';
TYPE_VAR: 'int' | 'float';
THEN: 'then';
IF: 'if';
ELSE: 'else';
ENDIF: 'endif';
AND: 'and';
OR: 'or';
REPEAT: 'repeat';
UNTIL: 'until';
BOOL: 'true' | 'false';
NUM: [0-9]+ ;
INPUT: 'input';
PRINT: 'print';
VAR_NAME: [a-zA-Z] [a-zA-Z0-9]*; //-> sem caseSensitive fica assim: ([a-z] | [A-Z]) ([a-z] | [A-Z] | NUM)*
STRING: '"' ~["\r\n\\]+ '"';


//comentários e espaços em branco
COMMENT: '{' .*? '}' -> skip;
WS     : [ \t\r\n]+ -> skip ;

//regras sintáticas (a gramática em si)
prog: START_PROG command* last_command END_PROG;
command: (decl | fun )';'; //não precisa colocar | COMMENT
last_command: decl | fun ; //comando sem ponto e vírgula
decl: decl_var | decl_atrib | decl_if | decl_repeat;
fun: input_fun | print_fun;
decl_var: ('var' VAR_NAME (',' VAR_NAME)* ':' TYPE_VAR);
decl_if: ( (IF '(' exp_bool ')' THEN (command* last_command) ) | (IF '(' exp_bool ')' THEN command* last_command  ELSE command* last_command)) ENDIF;
exp_bool: (exp_term ( (AND | OR) exp_term )*) | BOOL;
exp_term: '(' exp_bool ')' | exp_rela | exp_log; //permite parêntesis optativos
exp_rela: (VAR_NAME | NUM) ('>' |'>=' | '<' | '<=' | '==' | '!=') (VAR_NAME | NUM); //(VAR_NAME | exp_arit) ('>' |'>=' | '<' | '<=' | '==' | '!=') (VAR_NAME | exp_arit); ->se aceitasse expressões aritméticas tbm
exp_log: '!' VAR_NAME;
exp_arit: term (('+' | '-') term )*;
term: factor ( ('*' | '/' | '%') factor )*;
factor: NUM | VAR_NAME | '(' exp_arit ')';
decl_atrib: VAR_NAME ':=' exp_arit;
input_fun:  INPUT '(' VAR_NAME (',' VAR_NAME)* ')';
print_fun: PRINT '(' ( (STRING ',')* (VAR_NAME (',' VAR_NAME)*)* | STRING ) ')'; //o ou garante ter só uma string qualquer
decl_repeat: REPEAT command* last_command UNTIL '('exp_bool')';


