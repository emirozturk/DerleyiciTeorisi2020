build:
	flex lexer.l
	gcc lex.yy.c -o eLexer
	./eLexer source.e