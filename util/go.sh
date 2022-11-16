#!/bin/sh
. ./config.cfg
go() {
	if [ $doDownload = true ]; then
		download
	fi
}