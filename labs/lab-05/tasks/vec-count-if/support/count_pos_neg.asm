; SPDX-License-Identifier: BSD-3-Clause

%include "printf32.asm"

%define ARRAY_SIZE    10

section .data
    dword_array dd 1392, -12544, -7992, -6992, 7202, 27187, 28789, -17897, 12988, 17992
    pos_count dd 0          ; Variable to store the count of positive numbers
    neg_count dd 0          ; Variable to store the count of negative numbers

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    xor eax, eax            ; Clear eax (used for comparison)
    xor ebx, ebx            ; Clear ebx (used for positive count)
    xor edx, edx            ; Clear edx (used for negative count)
    mov ecx, ARRAY_SIZE     ; Set loop counter to ARRAY_SIZE

count_loop:
    mov esi, dword [dword_array + (ecx - 1) * 4] ; Load current array element into esi
    test esi, esi          ; Check if the number is negative or positive
    js is_negative         ; Jump if the number is negative (sign flag is set)

    ; Positive number
    inc ebx                ; Increment positive count
    jmp next_iteration     ; Skip to the next iteration

is_negative:
    inc edx                ; Increment negative count

next_iteration:
    loop count_loop        ; Decrement ecx and repeat if not zero

    ; Store the results in memory
    mov [pos_count], ebx   ; Store positive count
    mov [neg_count], edx   ; Store negative count

    ; Print the results
    PRINTF32 `Positive count: %u\n\x0`, ebx
    PRINTF32 `Negative count: %u\n\x0`, edx

    leave
    ret