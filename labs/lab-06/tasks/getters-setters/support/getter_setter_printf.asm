; SPDX-License-Identifier: BSD-3-Clause

%include "printf32.asm"

struc my_struct
    int_x: resb 4
    char_y: resb 1
    string_s: resb 32
endstruc

section .data
    sample_obj:
        istruc my_struct
            at int_x, dd 1000
            at char_y, db 'a'
            at string_s, db 'My string is better than yours', 0
        iend

    new_int dd 2000
    new_char db 'b'
    new_string db 'Are you sure?', 0

section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp

    PRINTF32 `int_x: %d\n\x0`, [sample_obj + int_x]
    PRINTF32 `char_y: %c\n\x0`, [sample_obj + char_y]
    PRINTF32 `string_s: %s\n\x0`, sample_obj + string_s

    ; Print all three values (int_x, char_y, string_s) from sample_obj.
    ; Hint: use "lea reg, [base + offset]" to save the result of
    ; "base + offset" into register "reg".

    ; TODO: write the equivalent of "sample_obj->int_x = new_int".
    mov edx, [new_int]
    mov dword [sample_obj + int_x], edx
    PRINTF32 `int_x: %d\n\x0`, [sample_obj + int_x]
    ; TODO: write the equivalent of "sample_obj->char_y = new_char".
    mov edx, [new_char]
    mov dword [sample_obj + char_y], edx
    PRINTF32 `char_y: %c\n\x0`, [sample_obj + char_y]
    ; TODO: write the equivalent of "strcpy(sample_obj->string_s, new_string)".

    lea eax, [new_string]
    lea ebx, [sample_obj + string_s]
    copy_string:
        mov edx, [eax]
        mov [ebx], edx
        inc eax
        inc ebx
        test edx, edx
        jnz copy_string

    ; Print the updated string
    PRINTF32 `string_s: %s\n\x0`, sample_obj + string_s

    ; TODO: print all three values again to validate the results of the
    ; three set operations above.

    xor eax, eax
    leave
    ret
