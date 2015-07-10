all: index.html

NAME1 := index
$(NAME1).html: $(NAME1).org Makefile ../bin/build $(shell which decktape)
	../bin/build $(NAME1)
