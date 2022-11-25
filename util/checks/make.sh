#!/bin/bash
checkMake() {
	printf "Checking for GNU Make... " 1>&2
	makePath=$(command -v make)
	makeFound=$?
	makeIsGMake=false
	if [ $makeFound -ne 0 ]; then
		# Before giving up, check for gmake as well
		makePath=$(command -v gmake)
		makeFound=$?
		if [ $makeFound -ne 0 ]; then
			printf "\x1b[31mnot found.\x1b[0m\r\n" 1>&2
			error "GNU Make wasn't found!  Please install it, then run this script again.\r\n"
		else
			export makeIsGMake=true
		fi
	else
		$makePath -f util/makeTest -q > tmp/make.log 2>&1
		makeRet=$?
		makeVersion=$(<tmp/make.log awk '{print $NF}')
		if [ $makeRet -ne 0 ]; then
			makeVersion="\x1b[31mError"
			error "Failed to get make version!  Perhaps this is BSD Make instead of GNU Make?\r\n"
		fi

		printf "\x1b[1;36mv$makeVersion \x1b[32mfound\x1b[0m at \x1b[33m%s\x1b[0m!\r\n" "$makePath" 1>&2
	fi
	cat << EOF > tmp/makeStuff.cfg
makeVersion=$makeVersion
makePath=$makePath
makeIsGMake=$makeIsGMake
EOF
}