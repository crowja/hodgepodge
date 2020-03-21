#include <stdlib.h>
#include <stdio.h>
#include <float.h>
#include <math.h>
#include <string.h>
#include "dtype.h"
#include "tinytest.h"
#include "tinyhelp.h"


static void
test_other(void)
{
   char test[100];
   fprintf_test_info(stdout, "test_other", "dtguess");
   strcpy(test, "");
   ASSERT_EQUALS(0, dtguess(test)); 
}

static void
test_int(void)
{
   char test[100];
   fprintf_test_info(stdout, "test_int", "dtguess");
   strcpy(test, "\t12345               ");
   ASSERT_EQUALS(1, dtguess(test)); 
   strcpy(test, "12345");
   ASSERT_EQUALS(1, dtguess(test)); 
   strcpy(test, "-12345");
   ASSERT_EQUALS(1, dtguess(test)); 
   strcpy(test, "+12345");
   ASSERT_EQUALS(1, dtguess(test)); 
   strcpy(test, "-0x12345");
   ASSERT_EQUALS(1, dtguess(test)); 
   strcpy(test, "- 12345");
   ASSERT_EQUALS(0, dtguess(test)); 
   strcpy(test, "12345 FACTOR");
   ASSERT_EQUALS(0, dtguess(test)); 
}

static void
test_double(void)
{
   char test[100];
   fprintf_test_info(stdout, "test_double", "dtguess");
   strcpy(test, "\t1.2345               ");
   ASSERT_EQUALS(2, dtguess(test)); 
   strcpy(test, "12345.");
   ASSERT_EQUALS(2, dtguess(test)); 
   strcpy(test, "-.12345");
   ASSERT_EQUALS(2, dtguess(test)); 
   strcpy(test, "+12345.");
   ASSERT_EQUALS(2, dtguess(test)); 
   strcpy(test, "- 1.2345");
   ASSERT_EQUALS(0, dtguess(test)); 
   strcpy(test, "-0e-20");
   ASSERT_EQUALS(2, dtguess(test)); 
   strcpy(test, "-0e-20 FACTOR");
   ASSERT_EQUALS(0, dtguess(test)); 
}

/* 7 yy */
#if 0
static void
test_stub(void)
{
   printf_test_name(stdout, "test_stub", NULL);
   ASSERT_EQUALS(0, 0);
}
#endif

int
main(void)
{
   RUN(test_other);
   RUN(test_int);
   RUN(test_double);
   return TEST_REPORT();
}
