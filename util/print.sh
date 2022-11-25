#!/bin/sh
note() {
	printf "\x1b[1;36m===> NOTE: \x1b[0m"
	printf "$1" # We do this separately because otherwise any escape sequences are ignored
	printf "\r\n"
}
warning() {
	printf "\x1b[1;33m===> WARNING: \x1b[0m"
	printf "$1"
	printf "\r\n"
}
error() {
	printf "\x1b[1;31m===> ERROR: \x1b[0m"
	printf "$1"
	printf "\r\n"
}
progressMajor() {
	printf "\x1b[1;32m"
	i=0
	while [ $i -lt $COLUMNS ]; do
		printf "="
		i=$((i + 1))
	done
	printf "\r\n# "
	progress "$1"
	i=0
	printf "\x1b[1;32m"
	while [ $i -lt $COLUMNS ]; do
		printf "="
		i=$((i + 1))
	done
	printf "\x1b[0m"
}
progress() {
	printf "\x1b[1;32m===> PROGRESS!: \x1b[0m"
	printf "$1"
	printf "\r\n"
}