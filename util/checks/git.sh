#!/bin/sh
. ./config.cfg
checkGit() {
	printf "Checking for git... " 1>&2
	gitPath=$(command -v git)
	gitFound=$?
	
	if [ $gitFound -ne 0 ]; then
		printf "\x1b[31mnot found.\x1b[0m\r\n" 1>&2
		error "Git wasn't found!  Please install it, then run this script again.\r\n"
	else
		printf "\x1b[32mfound\x1b[0m at \x1b[33m%s\x1b[0m!\r\n" "$gitPath" 1>&2
	fi

	printf "But does it work? " 1>&2
	# Check if we already git cloned before, in which case, don't redo it to avoid potentially getting rate limited.
	ls Testing/README.md > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		printf "\x1b[32myes\x1b[0m (cached).\r\n" 1>&2
	else
		git clone https://github.com/techflashYT/Testing > git.log 2>&1
		gitStatus=$?
		ls Testing/README.md > /dev/null 2>&1
		lsStatus=$?
		if [ $gitStatus -ne 0 ] || [ $lsStatus -ne 0 ]; then
			printf "\x1b[31mno.\r\n\x1b[0m" 1>&2
			error "Git was found, but it doesn't seem to be functioning correctly.\r\n"
			if [ "$verbose" = true ]; then
				error "There should be a \`\x1b[33mTesting\x1b[0m' folder that contains a file \`\x1b[33mREADME.md\x1b[0m'."
				error "There should also be a \`\x1b[33mgit.log\x1b[0m' file in the same directory as the \`\x1b[33mgo.sh\x1b[0m' script you just ran."
				error "If the directory does not exist, or the log file contains an error, please attempt to resolve it."
				error "If the issue persists, file a bug report with your \`\x1b[33mgit.log\x1b[0m' at the link below."
				note "\x1b[1;4;36mhttps://github.com/techflashYT/x86_64-elf-gcc-cross-compiler-builder"
			fi
		else
			printf "\x1b[32myes\x1b[0m.\r\n" 1>&2
		fi
	fi
}