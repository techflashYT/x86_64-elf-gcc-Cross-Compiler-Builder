#!/bin/sh
# shellcheck source=print.sh
. util/print.sh
leaveCustomize() {
	clear
	printf "\x1b[32mGood choice.\x1b[0m\r\n"
}
customize() {
	warning "\x1b[31mHey, are you sure you want to customize the install?\x1b[0m"
	warning "The default settings are just fine, and changing any of them \x1b[33mwill likely make it not work correctly\x1b[0m with Techflash OS."
	warning "If this isn't the case and the default settings somehow don't work, please file a bug report at the link below."
	warning "\x1b[1;4;36mhttps://github.com/techflashYT/x86_64-elf-gcc-cross-compiler-builder\x1b[0m"
	warning "If you are \x1b[33mABSOLUTELY\x1b[0m positive that you need to be here, say \x1b[31myes\x1b[0m, otherwise, say \x1b[32mno\x1b[0m"
	while true; do
		printf "Are you sure you want to proceed? (\x1b[31myes\x1b[0m/\x1b[32mno\x1b[0m) "
		read yesNo
		case $yesNo in
			yes) break;;
			[yY]) break;;
			no) leaveCustomize; return;;
			[nN]) leaveCustomize; return;;
			*) printf "\x1b[1;31mInvalid Option, please try again\r\n\x1b[0m";;
		esac
	done
	clear
	printf "As you wish...\r\n"
	error "This section is not yet implemented!  Returning to main menu..."
}