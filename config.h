/*
 * config.h: fpinit and script configuration
 */

#include <stddef.h>

#define DO_NOT_DEFINE_GREETING
#define GREETING BLUE "Welcome to " GREEN "fpinit v" VER BLUE " running on " YELLOW "Alpine Linux 3.12"
#define GREETING_LEN 53

static char *const rcinitcmd[]     = { "/usr/local/bin/script", "/usr/local/share/fpinit.d", NULL };
static char *const rcrebootcmd[]   = { "/usr/local/bin/script", "/usr/local/share/fphalt.d", NULL };
static char *const rcpoweroffcmd[] = { "/usr/local/bin/script", "/usr/local/share/fphalt.d", NULL };
