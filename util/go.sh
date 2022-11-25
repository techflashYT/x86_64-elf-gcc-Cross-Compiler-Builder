#!/bin/sh
# shellcheck source=../config.cfg
. ./config.cfg
# shellcheck source=download.sh
. util/download.sh
# shellcheck source=compile.sh
. util/compile.sh
go() {
	if [ $doDownload = true ]; then
		download
	fi
	compile
	progressMajor "ALL DONE!!!! Enjoy your cross compiler!  You can find it in \`$installPath/bin'.  I would highly recommend adding it to your path."
	exit 0
}