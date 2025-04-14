%include "printf32.asm"

section .data
    fmt db "gcd(%d, %d) = %d", 10, 0

section .text

extern printf
global main

main:
    mov eax, 49
    mov edx, 28

    push eax
    push edx

gcd:
    cmp eax, 0
    je gcd_end

    cmp eax, edx
    jle skip_swap

    xchg eax, edx

skip_swap:
    sub edx, eax
    jmp gcd

gcd_end:
    pop ecx        ; original edx (second number)
    pop ebx        ; original eax (first number)

print:
    push edx       ; result (GCD)
    push ecx       ; second number
    push ebx       ; first number
    push fmt
    call printf
    add esp, 16

    xor eax, eax
    ret
