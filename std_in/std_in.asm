section .rodata
    SYS_EXIT  equ 60
    EXIT_CODE equ 0
    ZERO_IN_ASCII equ 48
    usageStr db "Please give two integers as inputs", 10
    usageStrSize equ $ -usageStr
    newLine db "", 10

section .text
    global _start

_start:
    ;; Check two extra arguments have been given after the default argument of the program name
    pop rcx
    cmp rcx, 3
    jne usage
    xor r11, r11
    xor r10, r10

    ;; The first argument is the program name. We skip this by increasing the top of stack pointer by 8. 
    add rsp, 8

    ;; Get first input string argument and convert to int
    pop rsi
    call str_to_int
    mov r10, rax

    ;; Get second input string argement and convert to int
    pop rsi
    call str_to_int
    mov r11, rax

    ;; Sum given intergers and print
    add r10, r11
    mov rax, r10

    call int_to_str

str_to_int:
    ;; Break down the contents of rsi byte-by-byte, convert from ascii and add to rax
    xor rax, rax
    mov rcx, 10
l1:
    ;; Check if we are at the end of the string by looking for a NULL byte
    cmp [rsi], byte 0
    je return
    mov bl, [rsi]
    sub bl, ZERO_IN_ASCII
    mul rcx
    add rax, rbx
    inc rsi
    jmp l1

int_to_str:
    ;; Convert int to an ascii string by adding 48 to the remainder of the division operation
    ;; Put a new line at the end of the string
    xor rdx, rdx
    mov rcx, 10
    div rcx
    add rdx, ZERO_IN_ASCII
    add rdx, 0x0
    push rdx
    inc r12
    cmp rax, 0x0
    jne int_to_str
    jmp print
    
print:
    ;; Work out lenght in bytes
    mov rax, r12
    mov r12, 8
    mul r12
    mov rdx, rax

    ;;print to std out
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    syscall

    ;; Just to look cleaner I've added a new line
    mov rax, 1
    mov rdi, 1
    mov rsi, newLine
    mov rdx, 1
    syscall

    jmp exit

return:
    ret
 
usage:
    mov rax, 1
    mov rdi, 1
    mov rsi, usageStr
    mov rdx, usageStrSize
    syscall
    jmp exit

exit:
	mov rax, SYS_EXIT
	mov rdi, EXIT_CODE
	syscall

