section .data
    SYS_WRITE equ 1
    STD_OUT   equ 1
    SYS_EXIT  equ 60
    EXIT_CODE equ 0

    NEW_LINE db "", 10
    INPUTSTR db "Please reverse this string"

section .bss
    OUTPUTSTR resb 12    

section .text
    GLOBAL _start

_start:
    call reverse_str 
    call print_input
    call print_output
    jmp exit

reverse_str:
    ;; Store address for future ret
    pop r15  
    xor rdx, rdx
    xor rdi, rdi
    xor rax, rax
    xor rcx, rcx
    mov rsi, INPUTSTR
l1:
    ;; Check if we are at the end of the string by looking for a NULL byte
    cmp byte [rsi], 0
    je l2
    mov bl, [rsi]
    inc rsi
    ;; increase counter
    inc rdx
    ;; Push to the stack to reverse
    push rbx
    ;; loop again
    jmp l1
l2:
    cmp rcx, rdx
    je return
    pop rax
    mov [OUTPUTSTR + rcx], rax
    inc rcx
    jmp l2
 
return:
    push r15
    ret

print_input:
    mov rax, SYS_WRITE
    mov rdi, STD_OUT
    mov rsi, INPUTSTR
    mov rdx, rcx
    syscall
    jmp print_nline

print_output:
    mov rax, SYS_WRITE
    mov rdi, STD_OUT
    mov rsi, OUTPUTSTR
    mov rdx, rcx
    syscall
    jmp print_nline

print_nline:
    mov rax, SYS_WRITE
    mov rdi, STD_OUT
    mov rsi, NEW_LINE
    mov rdx, 1
    syscall
    ret

exit:
    mov rax, SYS_EXIT
    mov rdi, EXIT_CODE
    syscall
