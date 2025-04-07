; SPDX-License-Identifier: BSD-3-Clause

%include "printf32.asm"

%define ARRAY_SIZE    10

section .data
    byte_array db 8, 19, 12, 3, 6, 200, 128, 19, 78, 102
    word_array dw 1893, 9773, 892, 891, 3921, 8929, 7299, 720, 2590, 28891
    dword_array dd 1392849, 12544, 879923, 8799279, 7202277, 971872, 28789292, 17897892, 12988, 8799201
    dword_array2 dd 1392, 12544, 7992, 6992, 7202, 27187, 28789, 17897, 12988, 17992 ; for squares
    big_numbers_array dd 20000001, 3000000, 3000000, 23456789, 56789123, 123456789, 987654321, 56473829, 87564836, 777777777
    ; HINT: define two variables for the big_numbers_sum

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    mov ecx, ARRAY_SIZE     ; Use ecx as loop counter.
    xor eax, eax            ; Use eax to store the sum.
    xor edx, edx            ; Store current value in dl; zero entire edx.

add_byte_array_element:
    mov dl, byte [byte_array + ecx - 1]
    add eax, edx
    loop add_byte_array_element ; Decrement ecx, if not zero, add another element.

    PRINTF32 `Array sum is %u\n\x0`, eax

    ; Compute sum for elements in word_array
    mov ecx, ARRAY_SIZE     ; Reset loop counter
    xor eax, eax            ; Clear eax for the sum
    xor edx, edx            ; Clear edx

add_word_array_element:
    mov dx, word [word_array + (ecx - 1) * 2] ; Load word into dx
    add eax, edx            ; Add dx to eax
    loop add_word_array_element ; Decrement ecx, loop if not zero

    PRINTF32 `Word array sum is %u\n\x0`, eax

    ; Compute sum for elements in dword_array
    mov ecx, ARRAY_SIZE     ; Reset loop counter
    xor eax, eax            ; Clear eax for the sum

add_dword_array_element:
    add eax, dword [dword_array + (ecx - 1) * 4] ; Add dword to eax
    loop add_dword_array_element ; Decrement ecx, loop if not zero

    PRINTF32 `Dword array sum is %u\n\x0`, eax

    ; Compute the sum of squares for elements in dword_array2
    mov ecx, ARRAY_SIZE     ; Reset loop counter
    xor eax, eax            ; Clear eax for the sum
    xor edx, edx            ; Clear edx

sum_squares_dword_array2:
    mov ebx, dword [dword_array2 + (ecx - 1) * 4] ; Load dword into ebx
    imul ebx, ebx          ; Multiply ebx by itself
    add eax, ebx           ; Add the square to eax
    loop sum_squares_dword_array2 ; Decrement ecx, loop if not zero

    PRINTF32 `Sum of squares (dword_array2) is %u\n\x0`, eax

    ; Compute the sum of squares for elements in big_numbers_array
    mov ecx, ARRAY_SIZE     ; Reset loop counter
    xor eax, eax            ; Clear eax for the sum
    xor edx, edx            ; Clear edx
    xor ebx, ebx            ; Clear ebx for intermediate results

sum_squares_big_numbers:
    mov ebx, dword [big_numbers_array + (ecx - 1) * 4] ; Load dword into ebx
    imul ebx, ebx          ; Multiply ebx by itself
    add eax, ebx           ; Add the square to eax
    adc edx, 0             ; Add carry to edx
    loop sum_squares_big_numbers ; Decrement ecx, loop if not zero

    ; Print the result (edx:eax as a 64-bit number)
    PRINTF32 `Sum of squares (big_numbers_array) is %u (low) and %u (high)\n\x0`, eax, edx

    leave
    ret