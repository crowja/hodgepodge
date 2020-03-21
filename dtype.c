#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <stdio.h>
#include "dtype.h"

static int
str_isspace(const char *s)
{
   /* Tests if a string is entirely whitespace  */

   if (NULL == s)
      return 1;

   else {
      char     *cp = (char *) s;
      while (isspace((unsigned char) *cp))
         cp++;
      if (*cp == '\0')
         return 1;
      else
         return 0;
   }
}

int
dtguess(const char *s)
{
   char     *test;

   if (NULL == s || str_isspace(s))
      return 0;

   /* Test for integer */
   strtol(s, &test, 0);
   if ((s != test) && str_isspace(test))
      return 1;

   /* Not an integer, test for double */
   strtod(s, &test);
   if ((s != test) && str_isspace(test))
      return 2;
   else
      return 0;
}
