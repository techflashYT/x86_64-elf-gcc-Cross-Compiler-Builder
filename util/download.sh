#!/bin/sh
. ./config.cfg
. util/print.sh
download() {
	ls tmp/binutils > /dev/null 2>&1
	lsRet=$?
	progress "Downloading the Binutils source"
	if [ $lsRet -eq 0 ]; then
		while true; do
			printf "\x1b[1;36m===> NOTE:\x1b[0m Binutils source already cloned, would you like to redownload it? (yes/no) "
			read yesNo
			case $yesNo in
				yes) rm -rf tmp/binutils; doDownload=true; break;;
				[yY]) rm -rf tmp/binutils; doDownload=true; break;;
				no) doDownload=false; break;;
				[nN]) doDownload=false; break;;
				*) printf "\x1b[1;31mInvalid Option, please try again\r\n\x1b[0m";;
			esac
		done
	fi
	if [ $doDownload = true ]; then
		git clone git://sourceware.org/git/binutils-gdb.git --depth=1 tmp/binutils
	fi
	binutilsVer=$(printf "$(grep "PACKAGE_VERSION='" tmp/binutils/bfd/configure)" | sed 's/PACKAGE_VERSION='\''//g' | sed 's/'\''//g') # Get the version of the downloaded source
	progress "Binutils \x1b[1;36mv$binutilsVer\x1b[0m downloaded."
	progress "Downloading the GCC source"
}