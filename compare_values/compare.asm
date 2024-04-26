section .data
    num1: equ 100
    num2: equ 50
    msg: db "Sum is equal to 150", 10
    msgSize EQU $ -msg
    startMsg: db "In _start label", 10
    startMsgSize EQU $ -startMsg
    exitMsg: db "Program will now ext", 10
    exitMsgSize EQU $ -exitMsg

section .text
    global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, startMsg
    mov rdx, startMsgSize
    syscall

    mov rax, num1
    mov rbx, num2
    add rax, rbx
    cmp rax, 150
    je .match
    jmp .exit

.match:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msgSize
    syscall
    jmp .exit


.exit:
    mov rax, 1
    mov rdi, 1
    mov rsi, exitMsg
    mov rdx, exitMsgSize
    syscall

    mov rax, 60
    mov rdi, 0
    syscall
