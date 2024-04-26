section .data
msg: DB 'Hello World!', 10
msgSize EQU $ -msg

global start

section .text

    start:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msgSize
    syscall
    mov rax, 60
    mov rdi, 0
    syscall
    ret
