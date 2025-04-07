m; SPDX-License-Identifier: BSD-3-Clause

%include "printf32.asm"

; https://en.wikibooks.org/wiki/X86_Assembly/Arithmetic

section .data
    num1 db 43
    num2 db 39
    num1_w dw 1349
    num2_w dw 9949
    num1_d dd 134932
    num2_d dd 994912

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    ; Multiplication for db
    mov al, byte [num1]
    mov bl, byte [num2]
    mul bl

    ; Print result in hexa
    PRINTF32 `Result is: 0x%hx\n\x0`, eax

    mov ax, 1349
    mov bx, 9949
    mul bx

    xor ebx, ebx
    mov bx, dx
    shl ebx, 16
    mov bx, ax
    PRINTF32 `Result is: 0x%x\n\x0`, ebx

    mov eax, 134932
    mov ebx, 994912
    mul ebx
    PRINTF32 `Result is: 0x%x%x\n\x0`, edx, eax

    leave
    ret
