#include <stdlib.h>
#include <stdio.h>
#include <float.h>
#include <math.h>
#include <string.h>
#include "errmsg.h"
#include "tinytest.h"
#include "tinyhelp.h"

static void
test_func1(void)
{
   char       *cp = malloc(10000);

   fprintf_test_info(stdout, "test_func1", "hodgepodge_func1");
   memset(cp, 'a', 10000);
   ASSERT_EQUALS(0, 0);
   free(cp);
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
   RUN(test_func1);
   return TEST_REPORT();
}
