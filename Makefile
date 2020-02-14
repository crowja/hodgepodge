SHELL = /bin/sh

GCC_STRICT_FLAGS = -pedantic -ansi -W -Wall -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -O2
GCC_SANITIZE_FLAGS = -fsanitize=address -fsanitize=undefined -fno-omit-frame-pointer
OTHER_SOURCE = -I./t
OTHER_INCLUDE =
CPPFLAGS = -g -I. $(OTHER_INCLUDE)
CFLAGS = $(GCC_STRICT_FLAGS) 
LDFLAGS =
LDFLAGS_EFENCE = -L/usr/lib -lefence $(LDFLAGS)
#VALGRIND_FLAGS = --verbose --leak-check=full --undef-value-errors=yes --track-origins=yes
VALGRIND_FLAGS = --leak-check=full --undef-value-errors=yes

INDENT_FLAGS = -TFILE -Tsize_t -Tuint8_t

.PHONY: check check-examples
.PHONY: check_errmsg
.PHONY: echeck
.PHONY: indent
.PHONY: indent_errmsg
.PHONY: clean

TESTS_ERRMSG = t/test-errmsg
EXAMPLES = ex/ex_errmsg_1

errmsg.o: errmsg.c errmsg.h
	$(CC) -c $(CPPFLAGS) $(CFLAGS) -o $@ errmsg.c

check: check_errmsg

check_errmsg:
	@for i in $(TESTS_ERRMSG); \
	do \
	  echo "--------------------"; \
	  echo "Running test $$i"; \
	  ( $(CC)    $(CPPFLAGS) $(OTHER_INCLUDE) $(CFLAGS) $(OTHER_SOURCE) \
		-o t/a.out $$i.c errmsg.c $(LDFLAGS) ) \
	  && ( t/a.out ); \
	done 

indent: indent_errmsg

indent_errmsg:
	@stamper.bash errmsg.c && indent $(INDENT_FLAGS) errmsg.c
	@stamper.bash errmsg.h && indent $(INDENT_FLAGS) errmsg.h

clean:
	@/bin/rm -f *.o *~ *.BAK *.bak core.* a.out
	@/bin/rm -f t/*.o t/*~ t/*.BAK t/*.bak t/core.* t/a.out
	@/bin/rm -f ex/*.o ex/*~ ex/*.BAK ex/*.bak ex/core.* ex/a.out

