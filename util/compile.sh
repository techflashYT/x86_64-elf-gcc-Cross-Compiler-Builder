#!/bin/sh
. ./config.cfg
. util/print.sh
. tmp/versions.cfg
. tmp/makeStuff.cfg
compile() {
	progressMajor "COMPILING"
	progress "Configuring Binutils \x1b[1;36mv$binutilsVer\x1b[0m"
	ls tmp/build/binutils > /dev/null 2>&1
	lsRet=$?
	if [ $lsRet -eq 0 ]; then
		printf "\x1b[1;36m===> NOTE\x1b[0m: Binutils build directory already exists, do you want to remove it? (\x1b[33mrecommended\x1b[0m) (\x1b[33myes\x1b[0m/\x1b[31mno\x1b[0m) "
	fi
	mkdir -p tmp/build/binutils
	pushd tmp/build/binutils
	../../binutils/configure --target=$targetForCompiler --prefix="$installPath" --with-sysroot --disable-nls --disable-werror
	progressMajor "Compiling Binutils.  This might take a VERY long time."
	proc=$(nproc)
	if [ "$forceUseAllCPU" = "true" ]; then
		warning "Using ever CPU available, even if that could seriously slow down the system!"
	else
		if [ $proc -le 4 ]; then
			warning "4 or less processors, attempting to leave at least 2 usable for the system."
			proc=2
			if [ $proc -le 2 ]; then
				warning "Can't even do that! Doing this single threaded.  This is gonna be extremely slow."
				proc=1
			fi
		else
			# more than 4 processors, use 3/4 of them, or (num - 4) of them, whichever is more.
			procMult=$((proc * 3 / 4))
			procSubt=$((proc - 4))
			if [ $procMult -gt $procSubt ]; then
				proc=$procMult
			else
				proc=$procSubt
			fi
		fi
	fi
	$makePath -j$proc & 
	pid=$!
	while kill -0 "$pid" >/dev/null 2>&1; do
		printf "\x1b[0m" # Reset the effects since the multiple threads could easily break it.
		sleep 0.25
	done

	printf "\x1b[0m" # fix broken formatting incase the massive number of jobs messed it up (it did during testing)
	progressMajor "Please enter your password so that we can install the just compiled binutils!  \x1b[1;4;36mPress enter when you're ready\x1b[0m."
	read junk
	sudo $makePath install
	progressMajor "Compiling GCC"
	# Make sure that our freshly installed binutils binaries are in the path
	export PATH="$PATH:$installPath/bin"
	popd
	mkdir -p tmp/build/gcc
	pushd tmp/build/gcc
	../../gcc/configure --target=$targetForCompiler --disable-nls --enable-languages=c,c++ --without-headers --prefix=$installPath
	$makePath -j$proc all-gcc &
	pid=$!
	while kill -0 "$pid" >/dev/null 2>&1; do
		printf "\x1b[0m" # Reset the effects since the multiple threads could easily break it.
		sleep 0.25
	done
	$makePath -j$proc all-target-libgcc CFLAGS_FOR_TARGET='-g -fno-pic -O2 -mcmodel=kernel -mno-red-zone' &
	# just to make sure you realize, THE ABOVE COMMAND IS SUPPOSED TO FAIL!! ^^^^^^
	pid=$!
	while kill -0 "$pid" >/dev/null 2>&1; do
		printf "\x1b[0m" # Reset the effects since the multiple threads could easily break it.
		sleep 0.25
	done
	sed -i 's/-fpic//g' x86_64-elf/libgcc/Makefile
	$makePath -j$proc all-target-libgcc CFLAGS_FOR_TARGET='-g -fno-pic -O2 -mcmodel=kernel -mno-red-zone' & # Now that we patched it, everything should work.
	pid=$!
	while kill -0 "$pid" >/dev/null 2>&1; do
		printf "\x1b[0m" # Reset the effects since the multiple threads could easily break it.
		sleep 0.25
	done

	printf "\x1b[0m" # fix broken formatting incase the massive number of jobs messed it up (it did during testing)
	progressMajor "Please enter your password so that we can install the just compiled GCC!  \x1b[1;4;36mPress enter when you're ready\x1b[0m."
	read junk
	sudo $makePath install-gcc
	progressMajor "If you have a goofy sudo setup or an extremely slow disk, you may need to enter your password again here.  Just in case, pausing until you press enter."
	read junk
	sudo $makePath install-target-libgcc
}
