#!/bin/sh
checkGCC() {
	printf "Checking for gcc... "
	gccPath=$(command -v gcc)
	gccFound=$?
	if [ $gccFound -ne 0 ]; then
		printf "\x1b[31mnot found.\x1b[0m\r\n"
		error "GCC wasn't found!  Please install it, then run this script again."
		exit 1
	fi
	gccVersion=$(gcc -dumpfullversion -dumpversion)
	printf "\x1b[1;36mv%s \x1b[32mfound\x1b[0m at \x1b[33m%s\x1b[0m!\r\n" "$gccVersion" "$gccPath"
	printf "But does it work? "
	gcc util/checks/gccTest.c -o util/checks/gccTest
	testOut=$(util/checks/gccTest)
	testRet=$?
	if [ "$testOut" = "GCC is working!" ] && [ $testRet -eq 0 ]; then
		printf "\x1b[32myes\x1b[0m.\r\n"
	fi
}