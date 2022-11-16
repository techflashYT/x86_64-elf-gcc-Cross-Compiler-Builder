#!/bin/sh
. ./config.cfg
. util/download.sh
go() {
	if [ $doDownload = true ]; then
		download
	fi
}