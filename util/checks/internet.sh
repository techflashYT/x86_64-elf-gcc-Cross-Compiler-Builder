#!/bin/sh

checkInternet() {
	# redirect every normal output to stderr, and use stdout for errors so that we can capture it.  Goofy, I know.
	printf "Checking for internet connectivity... " 1>&2
	#ping -c 1 techflash.tk > /dev/null 2>&1
	#if [ $? -ne 0 ]; then
		# is my website just down?
		ping -c 1 google.com > /dev/null 2>&1
		if [ $? -ne 0 ]; then
			# either both my website and google are down at the same time, or the user has no internet, the latter is the most likely scenario, so assume no internet.
			printf "\x1b[31mnot connected\x1b[0m.\r\n" 1>&2
			error "No internet connection!  I have plans to add an offline mode later on, but it's not implemented yet.\r\n" # Error
		else
			# we got a response pinging google, but not my website
			printf "\x1b[32mconnected\x1b[0m.\r\n" 1>&2
		fi
	#else
		# we got a response pinging my website
	#	printf "\x1b[32mconnected\x1b[0m.\r\n" 1>&2
	#fi
}
