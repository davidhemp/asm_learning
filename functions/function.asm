section .data
msg: DB 'Hello World!', 10
msgSize EQU $ -msg

section .text
    global _start

_start:
    call .printHello

    mov rax, 60
    mov rdi, 0
    syscall
    ret

.printHello:
    mov rax, 1
    xor rdi, rdi
    mov rsi, msg
    mov rdx, msgSize
    syscall
    ret
