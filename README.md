# Mini-Shell-Linux



## **Summarizing Lex/Yacc:**
### YACC (Yet Another Compiler Compiler):

#### YACC input:
```
FIRST PART
%%
production          action
....
%%
THIRD PART
```
##### **FIRST PART:**
FIRST PART of a yacc specification contains:
* C declarations enclosed in %{ %}
* yacc definitions:
  * %start
  * %tokens
  * %union
  * type

##### **MIDDLE SECTION:**
-> represents a grammar - a set of productions. The left-hand side of a production is followed by a colon, and a right hand side.
-> multiple right-hand sides may follow separated by a '|'
-> Actions associated with a rule are entered in braces
###### examples:
* ```statements: statement {printf("statement");} | statement statements  {printf ("Statements\n);}```
    * ```$1, $2, ..., $n``` refer to the values associated with the symbols
    * ```$$``` refer to the value of the left
    * Default action: ```$$ = $1```  
* ```statement: identifier '+' identifier``` -> ```{ $$ = $1 + $3;}```
* ```statement: identifier '-' identifier``` -> ```{ $$ = $1 - $3;}```

##### **THIRD PART:**
-> contains valid C code that supports the language processing
  * symbol table implementation
  * functions that might be called by actions associated with productions in the middle part
