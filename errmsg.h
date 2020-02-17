/**
 *  @file errmsg.h
 *  @version 0.1.0
 *  @date Mon Feb 17, 2020 05:21:45 PM CST
 *  @copyright 2020 John A. Crow <crowja@gmail.com>
 *  @license Unlicense <http://unlicense.org/>
 */

#ifndef ERRMSG_H
#define ERRMSG_H

/**
 *  @brief Print an error, success, or warning message.
 */
void      errmsg_error(FILE *out, const char *info);    /* red */
void      errmsg_success(FILE *out, const char *info);  /* green */
void      errmsg_warning(FILE *out, const char *info);  /* yellow */

#endif
