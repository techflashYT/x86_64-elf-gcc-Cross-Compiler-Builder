#!/bin/sh
. util/print.sh
. util/checks/internet.sh
. util/checks/git.sh
. util/checks/gcc.sh
systemCheck() {
	checkInternet # Check for internet
	checkGit # Check for git
	checkGCC # Check for GCC and wether it works or not
	printf "\x1b[32mYour system passed the check\x1b[0m.  Continuing...\r\n\r\n"
}