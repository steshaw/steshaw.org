all: index.html notes.html

NAME1 := index
$(NAME1).html: $(NAME1).org Makefile ../bin/build $(shell which decktape)
	../bin/build $(NAME1)

NAME2 := notes
$(NAME2).html: $(NAME2).org Makefile ../bin/build $(shell which decktape)
	../bin/build $(NAME2)
