#!/bin/bash
# Trust me I don't want to use bash just as much as I'm sure you reading this don't want to see it,
# but for some reason the escape codes just don't work right under dash/sh
. util/version.sh
. util/print.sh
. util/customize.sh
. util/leave.sh
. util/systemCheck.sh
. util/go.sh
mkdir -p tmp
printf "\x1b[1;33mTechflash \x1b[32mx86-64_elf-gcc\x1b[0m Builder\x1b[1;36m v%s.%s.%s\x1b[0m\r\n" $vMajor $vMinor $vPatch
note "This script will build the cross compiler needed to compile \x1b[33mTechflash OS\x1b[0m."
note "While it may work for other uses, this is not a guarantee.\r\n"
warning "This program will compile and install the \x1b[1;39m*LATEST*\x1b[0m version of GCC and Binutils."
warning "This means that the installed version may have bugs."
warning "If problems persist, please try to rebuild with the current latest version."
printf "\r\n\r\n"
printf "\x1b[33mPerforming system check.  Please wait.\x1b[0m\r\n"
systemCheck

menu() {
	printf "\
Please choose one of the following options: 
1) \x1b[32mGo!\x1b[0m
\x1b[31m2) Customize \x1b[33m(\x1b[31mDANGEROUS!\x1b[33m)\x1b[0m
3) \x1b[36mQuit\x1b[0m
Please enter your choice: "
	read choice
	case $choice in
		1) go;;
		g) go;;
		2) customize;;
		c) customize;;
		3) leave;;
		q) leave;;
		*) clear; printf "\x1b[1;31mInvalid Option, please try again\r\n\x1b[0m";;
	esac
}
while true; do
	menu
done