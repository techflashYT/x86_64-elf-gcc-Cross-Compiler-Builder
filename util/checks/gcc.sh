#!/bin/sh
checkGCC() {
	printf "Checking for gcc... " 1>&2
	gccPath=$(command -v gcc)
	gccFound=$?
	if [ $gccFound -ne 0 ]; then
		printf "\x1b[31mnot found.\x1b[0m\r\n" 1>&2
		error "GCC wasn't found!  Please install it, then run this script again.\r\n"
	else
		gccVersion=$(gcc -dumpfullversion -dumpversion)
		printf "\x1b[1;36mv%s \x1b[32mfound\x1b[0m at \x1b[33m%s\x1b[0m!\r\n" "$gccVersion" "$gccPath" 1>&2
		printf "But does it work? " 1>&2
		gcc util/checks/gccTest.c -o util/checks/gccTest 1>&2
		testOut=$(util/checks/gccTest)
		testRet=$?
		if [ "$testOut" = "GCC is working!" ] && [ $testRet -eq 0 ]; then
			printf "\x1b[32myes\x1b[0m.\r\n" 1>&2
		else
			printf "\x1b[31mno\x1b[0m.\r\n" 1>&2
			error "GCC was found, but it isn't working correctly!\r\n"
		fi
	fi
}