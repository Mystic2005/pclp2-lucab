; SPDX-License-Identifier: BSD-3-Clause

%include "printf32.asm"

section .data
    myString: db "Hello, World!", 0
    myString2: db "Goodbye, World!", 0
    N: dd 6                         ; N = 6

section .text
    global main
    extern printf

main:
    mov ecx, DWORD [N]              ; ecx will store the value of N
    PRINTF32 `%d\n\x0`, ecx         ; DO NOT REMOVE/MODIFY THIS LINE

    mov eax, 2
    mov ebx, 1
    cmp eax, ebx
    jg print
    ret

print:

    iterate:
        cmp ecx, 0
        jz out
        PRINTF32 `%s\n\x0`, myString
        dec ecx
        jmp iterate
    out:
        PRINTF32 `%s\n\x0`, myString2

    ret
