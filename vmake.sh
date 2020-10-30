#!/bin/bash

mfile=vMakefile

if [ $# > 0 ]; then
    for i in "$@"
    do
        if [ "$i" == "--help" ] || [ "$i" == "-h" ]; then
            echo -e "\nvMakefile Commands: \n\n-TOPMOD: Specify the top module\n-FILE: add Verilog file to be compiled\n-WAVEFORM: Specify .vcd file for gtkwave\n-#: [comments]\n\n"
            echo -e "vMakefile Example:\n\n#vMakefile for and_not_testbench\nTOPMOD=and_not_testbench\n\nWAVEFORM=and_not_testbench_waves.vcd\n\nFILE=and_not_testbench.v\nFILE=and_gate.v\nFILE=not_gate.v\n\n"
            exit 0
        elif [ "$i" == "-f" ]; then
            shift
            if [ $# > 0 ]; then
                mfile=$1
                echo "Makefile: $1"
                echo ""
            fi
        fi
    done    
fi

if !(test -f $mfile); then
    echo "cannot find vMakefile"
    echo -e "\nvMakefile Commands: \n\n-TOPMOD: Specify the top module\n-FILE: add Verilog file to be compiled\n-WAVEFORM: Specify .vcd file for gtkwave\n-#: [comments]\n\n"
    echo -e "vMakefile Example:\n\n#vMakefile for and_not_testbench\nTOPMOD=and_not_testbench\n\nWAVEFORM=and_not_testbench_waves.vcd\n\nFILE=and_not_testbench.v\nFILE=and_gate.v\nFILE=not_gate.v\n\n"
    exit 127
fi

srcfiles=""
topmod=""
waveforms=''

while read -r line
do
    if [ -n "$(echo $line | grep "=")" ] && [ -z "$(echo $line | grep "#")" ]; then
        field=$(echo $line | cut -d "=" -f 1)
        data=$(echo $line | cut -d "=" -f 2)
        if [ "$field" == "TOPMOD" ]; then
            topmod="$data"
        elif [ "$field" == "FILE" ]; then
            srcfiles="$srcfiles $data"
        elif [ "$field" == "WAVEFORM" ]; then
            waveforms="$waveforms $data"
        fi
    fi
done < $mfile

iverilog -Wall -g2012 -s $topmod -o $topmod $srcfiles
./$topmod

if [ -n "$waveforms" ]; then
    gtkwave $waveforms
fi