%include "printf32.asm"

%define ARRAY_1_LEN 5
%define ARRAY_2_LEN 7
%define ARRAY_OUTPUT_LEN 12

section .data
array_1 dd 27, 46, 55, 83, 84
array_2 dd 1, 4, 21, 26, 59, 92, 105

section .text
extern printf
global main

main:
    sub esp, 96 ; reserve space on stack

    mov esi, array_1
    lea edi, [esp + 76]
    mov ecx, ARRAY_1_LEN
.copy1:
    mov eax, [esi]
    mov [edi], eax
    add esi, 4
    add edi, 4
    loop .copy1

    mov esi, array_2
    lea edi, [esp + 48]
    mov ecx, ARRAY_2_LEN
.copy2:
    mov eax, [esi]
    mov [edi], eax
    add esi, 4
    add edi, 4
    loop .copy2

    mov eax, 0 ; index for array_1
    mov ebx, 0 ; index for array_2
    mov ecx, 0 ; index for output array

merge_arrays:
    mov edx, [esp + 76 + 4*eax]
    cmp edx, [esp + 48 + 4*ebx]
    jg array_2_lower
array_1_lower:
    mov [esp + 4*ecx], edx
    inc eax
    inc ecx
    jmp verify_array_end
array_2_lower:
    mov edx, [esp + 48 + 4*ebx]
    mov [esp + 4*ecx], edx
    inc ebx
    inc ecx

verify_array_end:
    cmp eax, ARRAY_1_LEN
    jge copy_array_2
    cmp ebx, ARRAY_2_LEN
    jge copy_array_1
    jmp merge_arrays

copy_array_1:
    mov edx, [esp + 76 + 4*eax]
    mov [esp + 4*ecx], edx
    inc ecx
    inc eax
    cmp eax, ARRAY_1_LEN
    jb copy_array_1
    jmp print_array

copy_array_2:
    mov edx, [esp + 48 + 4*ebx]
    mov [esp + 4*ecx], edx
    inc ecx
    inc ebx
    cmp ebx, ARRAY_2_LEN
    jb copy_array_2

print_array:
    PRINTF32 `Array merged:\n\x0`
    mov ecx, 0
print:
    mov eax, [esp + 4*ecx]
    PRINTF32 `%d \x0`, eax
    inc ecx
    cmp ecx, ARRAY_OUTPUT_LEN
    jb print

    PRINTF32 `\n\x0`
    add esp, 96     ; clean up the stack before exit
    xor eax, eax
    ret
