# What is this?

This project is a collection of scripts that provides a user-friendly way to build the `x86_64-elf` cross compilation toolchain.  
This is this toolchain that is used by many of my bare-metal projects, like [TFBoot](https://github.com/techflashYT/TFBoot), or [Techflash OS](https://github.com/techflashYT/Techflash-OS).  
  
It goes through a few steps to make sure that your system is prepared to build the cross compiler first though:
- Checks for internet connectivity (to download the source code)
- Checks for `git` (and if it's working)
- Checks for gcc & binutils (and if it's working)
- Checks for make