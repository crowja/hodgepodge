SHELL = /bin/sh

GCC_STRICT_FLAGS = -pedantic -ansi -W -Wall -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -O2
GCC_SANITIZE_FLAGS = -fsanitize=address -fsanitize=undefined -fno-omit-frame-pointer
OTHER_SOURCE = -I./t
OTHER_INCLUDE =
CPPFLAGS = -g -I. $(OTHER_INCLUDE)
CFLAGS = $(GCC_STRICT_FLAGS) 
##CFLAGS = 
LDFLAGS =
LIBS = -lm
LDFLAGS_EFENCE = $(LDFLAGS)
LIBS_EFENCE = -L/usr/lib -lefence $(LIBS)
##VALGRIND_FLAGS = --verbose --leak-check=full --undef-value-errors=yes --track-origins=yes
VALGRIND_FLAGS = --leak-check=full --undef-value-errors=yes
STAMPER = stamper

INDENT_FLAGS = -TFILE -Tsize_t -Tuint8_t

.PHONY: all
.PHONY: check check-examples
.PHONY: check_dtype
.PHONY: check_errmsg
.PHONY: echeck
.PHONY: indent
.PHONY: indent_dtype
.PHONY: indent_errmsg
.PHONY: stamp
.PHONY: clean

TESTS_DTYPE = t/test-dtype
TESTS_ERRMSG = t/test-errmsg
EXAMPLES = ex/ex_errmsg_1

all: dtype.o errmsg.o

dtype.o: dtype.c dtype.h
	$(CC) -c $(CPPFLAGS) $(CFLAGS) -o $@ dtype.c

errmsg.o: errmsg.c errmsg.h
	$(CC) -c $(CPPFLAGS) $(CFLAGS) -o $@ errmsg.c

check: check_dtype check_errmsg

check_dtype:
	@for i in $(TESTS_DTYPE); \
	do \
	  echo "--------------------"; \
	  echo "Running test $$i"; \
	  ( $(CC)    $(CPPFLAGS) $(OTHER_INCLUDE) $(CFLAGS) $(OTHER_SOURCE) \
		-o t/a.out $$i.c dtype.c $(LDFLAGS) $(LIBS) ) \
	  && ( t/a.out ); \
	done 

check_errmsg:
	@for i in $(TESTS_ERRMSG); \
	do \
	  echo "--------------------"; \
	  echo "Running test $$i"; \
	  ( $(CC)    $(CPPFLAGS) $(OTHER_INCLUDE) $(CFLAGS) $(OTHER_SOURCE) \
		-o t/a.out $$i.c errmsg.c $(LDFLAGS) $(LIBS) ) \
	  && ( t/a.out ); \
	done 

indent: indent_dtype indent_errmsg

indent_dtype:
	@indent $(INDENT_FLAGS) dtype.c
	@indent $(INDENT_FLAGS) dtype.h

indent_errmsg:
	@indent $(INDENT_FLAGS) errmsg.c
	@indent $(INDENT_FLAGS) errmsg.h

stamp:
	@$(STAMPER) dtype.c
	@$(STAMPER) dtype.h
	@$(STAMPER) errmsg.c
	@$(STAMPER) errmsg.h

clean:
	@/bin/rm -f *.o *~ *.BAK *.bak core.* a.out
	@/bin/rm -f t/*.o t/*~ t/*.BAK t/*.bak t/core.* t/a.out
	@/bin/rm -f ex/*.o ex/*~ ex/*.BAK ex/*.bak ex/core.* ex/a.out

