section .data
    tenMsg: db "Got the value 10 from the top of the stack", 10
    tenMsgSize EQU $ -tenMsg
    oneMsg: db "Got the value 1 from the bottom of the stack", 10
    oneMsgSize EQU $ -oneMsg

section .text
    global _start

_start:
    mov rax, 1
    mov rdx, 10
    ;; Push values to stack
    push rax
    push rdx
    
    ;; RBP points to the base of the current stack frame and RSP points to the top of the current stack frame
    ;; Here we add 8 to RSP move down 1 8bit address. As the stack is LIFO this will be 10
    mov rbx, 8 * 1
    mov rcx, [rsp + rbx]

    cmp rcx, 1
    je .isOne

.ret1:
    pop rcx 
    cmp rcx, 10
    je .isTen

.ret2:
    jmp .exit

.isOne:
    mov rax, 1
    mov rdi, 1
    mov rsi, oneMsg
    mov rdx, oneMsgSize
    syscall
    jmp .ret1

.isTen:
    mov rax, 1
    mov rdi, 1
    mov rsi, tenMsg
    mov rdx, tenMsgSize
    syscall
    jmp .ret2

.exit:  
    mov rax, 60
    mov rdi, 0
    syscall
    ret
