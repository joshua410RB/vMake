#vMake
## Introduction

vMake wraps the Verilog Compile - Simulate - Waveform View workflow into a single command. vMake runs the Icarus Verilog compiler, the simulation and gtkwave 

vMake uses a makefile called vMakefile to specify the top module and source files for the compiler and the waveform files for gtkwave


## Installation
Clone or download the repo and the setup.sh with sudo permissions (as it will copy the needed file to /usr/local/bin to allow program to be run from any directory)

## Prerequisites
vMake requires Icarus Verilog and gtkwave to be installed 

## Usage
Note: the vMakefile for the project must be present in the directory

Type "vMake" into the terminal 
```    vMake```

Show help:
``` vMake --help```

## vMakefile
the vMakefile contains the details of the top module and source files for the verilog compiler and any waveform files to be viewed in gtkwave

(a sample vMakefile is included in the repo)

### Syntax
TOPMOD=[name of top module]
 - if called more than once, the latest call will take precedence

FILE=[name of Verilog source file to add to compiler]
 - only 1 file can be added at a time
 - can be used multiple times to add different files

WAVEFORM=[name of waveform file to be viewed in gtkwave]
 - if no waveform files are specified, gtkwave will not be run

 "#" Comments
 - does not support same line comments (yet)
