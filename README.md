# Mini Shell Linux

## **Overview**
A mini shell is constructed in linux to perform the user commands using multiple languages: lex, yacc and c++. 

## Prerequistes

1. Ubuntu Operating System
2. Bash Shell

## Installation

To install the Directory Backup, follow these steps:

- Clone or download the code to your machine.
- Open a terminal and navigate to the downloaded code directory.
- Assure that the prerequistes are installed, if not install them using the following command:

```bash
sudo apt-get install bash
```

## **Running the MiniShell:**
To run the minishell, please insert the following commands in the terminal:
 * ```make```
 * ```./shell```

Then the shell is ready for execution and it will appear as ```myshell>```

For any updates in the files, remake the building by inserting before the previous commands:
```make clean```
---
## **Summarizing Lex/Yacc:**
### LEX (Lexer Generator):

#### LEX structure:
```
FIRST PART
%%
rule          action
...
%%
THIRD PART
```
Lex is a lexer generator that is often used in conjunction with Yacc to build compilers and interpreters. It helps in tokenizing the input stream and generating lexical analyzers.

#### **A Lex file consists of three main parts:**

##### **FIRST PART:**

The first part of a Lex specification typically contains:

* C declarations enclosed in %{ %}
* Lex definitions:
 * Regular expressions and corresponding actions

##### **SECOND PART:**

The second part of a Lex specification contains a set of rules that define the patterns to be recognized and the corresponding actions to be taken when a pattern is matched. Each rule consists of a regular expression pattern and an associated action.

The format of a rule is:
```
pattern    action
```
where pattern is a regular expression and action is the code to be executed when the pattern is matched.

##### **THIRD PART:**

The third part of a Lex specification contains valid C code that supports the language processing. This part typically includes:

* Additional functions or data structures used by the lexer
* Code snippets that are called by the actions in the second part of the Lex specification

---
### YACC (Yet Another Compiler Compiler):

#### YACC structure:
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

-> multiple right-hand sides may follow separated by a '|'.

-> Actions associated with a rule are entered in braces.

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
