#!/bin/bash
# shellcheck source=print.sh
. util/print.sh
# shellcheck source=checks/internet.sh
. util/checks/internet.sh
# shellcheck source=checks/git.sh
. util/checks/git.sh
# shellcheck source=checks/gcc.sh
. util/checks/gcc.sh
# shellcheck source=checks/make.sh
. util/checks/make.sh

systemCheck() {
	errors=""
	errors+="$errors$(checkInternet)" # Check for internet
	errors+="$errors$(checkGit)" # Check for git
	errors+="$errors$(checkGCC)" # Check for GCC and wether it works or not
	errors+="$errors$(checkMake)" # Check for GNU Make and wether it works or not
	if [ "$errors" != "" ]; then
		error "Errors were detected during the system check!"
		error "Please resolve the following before running the script."
		printf "$errors\r\n"
		exit 1
	fi
	printf "\x1b[32mYour system passed the check\x1b[0m.  Continuing...\r\n\r\n"
}