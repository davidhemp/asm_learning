section .data
    SYS_WRITE   equ     1
    STD_OUT     equ     1
    SYS_EXIT    equ     60
    EXIT_CODE   equ     0
    NEW_LINE    db      "", 10
 
section .bss
    OUTPUTSTR   RESQ    1
    var         RESQ    1

section .text
    GLOBAL _start

_start:
l1:
    mov rcx, [var]
    add rcx, 48
    mov [OUTPUTSTR], rcx

    call print_out

    mov rcx, [var]
    add rcx, 2
    mov rbx, 10
    cmp rcx, rbx
    je exit
    mov [var], rcx
    jmp l1

print_out:
    mov rsi, OUTPUTSTR
    call print
    mov rsi, NEW_LINE
    call print
    ret

print:
    mov rax, SYS_WRITE
    mov rdi, STD_OUT
    mov rdx, 1
    syscall
    ret

exit:
    mov rax, SYS_EXIT
    mov rdi, EXIT_CODE
    syscall     

