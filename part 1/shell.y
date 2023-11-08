
/*
 * CS-413 Spring 98
 * shell.y: parser for shell
 *
 * This parser compiles the following grammar:
 *
 *	cmd [arg]* [> filename]
 *
 * you must extend it to understand the complete shell grammar
 *
 */

%token	<string_val> WORD

%token 	NOTOKEN GREAT NEWLINE PIPE BACKGROUND APPEND LESS

%union	{
		char   *string_val;
	}

%{
extern "C" 
{
	int yylex();
	void yyerror (char const *s);
}
#define yylex yylex
#include <stdio.h>
#include "command.h"
%}

%%

goal:	
	commands
	;

commands: 
	command
	| commands command
	| commands PIPE command 
	;

command: 
	simple_command
	;

simple_command:	
	command_and_args iomodifier_opt background_opt NEWLINE {
		printf("   Yacc: Execute command\n");
		Command::_currentCommand.execute();
		//Command::_currentCommand.clear();
	}
	| NEWLINE 
	| error NEWLINE { yyerrok; }
	;

command_and_args:
	command_word arg_list {
		Command::_currentCommand.
			insertSimpleCommand( Command::_currentSimpleCommand );
	}
	| command_and_args PIPE command_word arg_list {
		printf("   Yacc: Create pipe\n");
		Command::_currentCommand.
			insertSimpleCommand( Command::_currentSimpleCommand );
	
	}
	;

arg_list:
	arg_list argument
	| /* can be empty */
	;

argument:
	WORD {
               printf("   Yacc: insert argument \"%s\"\n", $1);

	       Command::_currentSimpleCommand->insertArgument( $1 );\
	}
	;

command_word:
	WORD {
               printf("   Yacc: insert command \"%s\"\n", $1);
	       
	       Command::_currentSimpleCommand = new SimpleCommand();
	       Command::_currentSimpleCommand->insertArgument( $1 );
	}
	;

iomodifier_opt:
	iomodifier_opt iomodifier
	| /* can be empty */ 
	;

iomodifier:
	GREAT WORD {
		printf("   Yacc: insert output redirection \"%s\"\n", $2);
		Command::_currentCommand._outFile = $2;
	}
	| LESS WORD {
		printf("   Yacc: insert input redirection \"%s\"\n", $2);
		Command::_currentCommand._inputFile = $2;
	}
	| APPEND WORD {
		printf("   Yacc: insert append redirection \"%s\"\n", $2);
		Command::_currentCommand._appendFile = $2; //check
	}
	;
	
background_opt:
	BACKGROUND {
		printf("   Yacc: set background execution \n");
		Command::_currentCommand._background = 1;
	}
	| /* can be empty */ 
	;

%%

void
yyerror(const char * s)
{
	fprintf(stderr,"%s", s);
}

#if 0
main()
{
	yyparse();
}
#endif
