#ifndef DTYPE_H
#define DTYPE_H

/**
 *  @brief Identify the numerical datatype corresponding to a string.
 *  @details Identify the numerical datatype in a string, either long integer
 *  or double.
 *  @param s [in] Pointer to a string.
 *  @returns Returns 1 if long integer, 2 if double, 0 otherwise. If s is NULL
 *  0 is returned.
 */
int       dtguess(const char *s);

#endif
