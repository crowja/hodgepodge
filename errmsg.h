#ifndef ERRMSG_H
#define ERRMSG_H

/**
 *  @brief Print an error, success, or warning message.
 */
void      errmsg_error(FILE *out, const char *info);    /* red */
void      errmsg_success(FILE *out, const char *info);  /* green */
void      errmsg_warning(FILE *out, const char *info);  /* yellow */

#endif
