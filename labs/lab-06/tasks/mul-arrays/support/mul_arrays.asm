; SPDX-License-Identifier: BSD-3-Clause

%include "printf32.asm"

section .bss
    array3: resw 10             ; Reserve space for 10 words (16-bit integers)

section .data
    array1: db 27, 35, 46, 14, 17, 29, 37, 104, 135, 124
    array2: db 15, 38, 44, 20, 17, 33, 78, 143, 132, 16

    print_format db "%d ", 0    ; Format string for printing integers
    newline db 10, 0           ; Newline character

section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp

    ; Initialize loop counter
    mov ecx, 10                ; Loop counter for 10 elements
    xor esi, esi               ; Index for array1 and array2
    xor edi, edi               ; Index for array3

    ; Multiply corresponding elements of array1 and array2
multiply_arrays:
    movzx eax, byte [array1 + esi] ; Load byte from array1 into eax
    movzx ebx, byte [array2 + esi] ; Load byte from array2 into ebx
    imul eax, ebx                  ; Multiply eax by ebx
    mov word [array3 + edi], ax    ; Store the result (16-bit) in array3
    inc esi                        ; Increment index for array1 and array2
    add edi, 2                     ; Increment index for array3 (word size)
    loop multiply_arrays            ; Repeat for all elements

    ; Print the resulting array3
    PRINTF32 `The array that results from the product of the corresponding elements in array1 and array2 is:\n\x0`
    mov ecx, 10                ; Reset loop counter for printing
    xor esi, esi               ; Reset index for array3

print_array3:
    movzx eax, word [array3 + esi] ; Load word from array3 into eax
    push eax                       ; Push the value to the stack
    push print_format              ; Push the format string
    call printf                    ; Print the value
    add esp, 8                     ; Clean up the stack
    add esi, 2                     ; Increment index for array3 (word size)
    loop print_array3              ; Repeat for all elements

    ; Print a newline
    push newline
    call printf
    add esp, 4

    leave
    ret