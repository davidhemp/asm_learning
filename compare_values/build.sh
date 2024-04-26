#!/bin/bash

module purge
module load tools/prod
module load Yasm/1.3.0-GCCcore-12.3.0
yasm -f elf64 -Worphan-labels compare.asm
ld -o compare.elf compare.o

