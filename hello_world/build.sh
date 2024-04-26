#!/bin/bash

module purge
module load tools/prod
module load Yasm/1.3.0-GCCcore-12.3.0
yasm -f elf64 -Worphan-labels hello_64.asm
ld -e start -o hello_64.elf hello_64.o

