# Canary
A hobby operating system written from scratch.

NOTE: If you are using vscode, then please refer to [VSCODE.md](https://github.com/NeoGenio/Canary/blob/main/VSCODE.md)

## Requirements

* [Toolchain](https://github.com/NeoGenio/Canary-Toolchain/blob/master/README.md)
* CMake
* Make
* GDB (for debugging)
* Qemu

## Building

First, clone this repo using `git clone --recursive https://github.com/NeoGenio/Canary.git` to clone all submodules as well.

Then in the project directory run the following commands:
```
$ mkdir build
$ cd build
$ cmake ..
$ make
```

You should get a new 'bin' folder with the flat binaries and the floppy image.

## Running

Go into the 'bin' folder and run:
```
$ qemu-system-x86_64 -fda bin/Canary.img
```

## Resources used

* [OSDev Wiki](https://wiki.osdev.org/Expanded_Main_Page)
* [Operating System Development Guide](http://www.independent-software.com/operating-system-development.html)