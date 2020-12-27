/*
 * fpinit.c: fast parallel init
 *
 * suckless' simple init (sinit), with tweaks
 */

#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/reboot.h>

#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define LEN(x)  (sizeof (x) / sizeof *(x))
#define TIMEO 30

#define RED     "\x1b[31m"
#define GREEN   "\x1b[32m"
#define YELLOW  "\x1b[33m"
#define BLUE    "\x1b[34m"
#define MAGENTA "\x1b[35m"
#define CYAN    "\x1b[36m"
#define RESET   "\x1b[0m"

static void  sigpoweroff(void);
static void  sigreap(void);
static void  sigreboot(void);
static pid_t spawn(char *const []);

static struct {
  int sig;
  void (*handler)(void);
} sigmap[] = {
  { SIGUSR1, sigpoweroff },
  { SIGCHLD, sigreap     },
  { SIGALRM, sigreap     },
  { SIGINT,  sigreboot   },
};

#include "config.h"

static sigset_t set;

int
main(int argc, char **argv)
{
  int sig;
  size_t i;

  if (getpid() != 1){
    if (argc == 2){
      if (argv[1][0] == '0'){
        sigpoweroff();
      } else if (argv[1][0] == '6'){
        sigreboot();
      }
    }
    printf(RED "fpinit must be run as PID 1.\n" YELLOW "To power off the system, please run " GREEN "fpinit 0" YELLOW ".\n" YELLOW "To reboot the system, please run " GREEN "fpinit 6" YELLOW ".\n" RESET);
    return 1;
  }
  chdir("/");
  sigfillset(&set);
  sigprocmask(SIG_BLOCK, &set, NULL);
  spawn(rcinitcmd);
  while (1) {
    alarm(TIMEO);
    sigwait(&set, &sig);
    for (i = 0; i < LEN(sigmap); i++) {
      if (sigmap[i].sig == sig) {
        sigmap[i].handler();
        break;
      }
    }
  }
  /* not reachable */
  return 0;
}

static void
sigpoweroff(void)
{
  waitpid(spawn(rcpoweroffcmd), NULL, 0);
  reboot(RB_POWER_OFF);
}

static void
sigreap(void)
{
  while (waitpid(-1, NULL, WNOHANG) > 0)
    ;
  alarm(TIMEO);
}

static void
sigreboot(void)
{
  waitpid(spawn(rcrebootcmd), NULL, 0);
  reboot(RB_AUTOBOOT);
}

static pid_t
spawn(char *const argv[])
{
  pid_t pid;
  switch ((pid=fork())) {
  case 0:
    sigprocmask(SIG_UNBLOCK, &set, NULL);
    setsid();
    execvp(argv[0], argv);
    perror("execvp");
    _exit(1);
  case -1:
    perror("fork");
  default:
    return pid;
  }
}
