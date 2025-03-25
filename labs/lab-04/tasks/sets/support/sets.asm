; SPDX-License-Identifier: BSD-3-Clause

%include "printf32.asm"

section .data
    FIRST_SET: dd 139   ; The first set
    SECOND_SET: dd 169  ; The second set

section .text
    global main
    extern printf

main:
    ; The two sets can be found in the FIRST_SET and SECOND_SET variables
    mov eax, DWORD [FIRST_SET]
    mov ebx, DWORD [SECOND_SET]
    PRINTF32 `%u\n\x0`, eax ; print the first set
    PRINTF32 `%u\n\x0`, ebx ; print the second set

    mov edx, eax;
    or edx, ebx; TODO1: reunion of the two sets
    PRINTF32 `%u\n\x0`, edx


    or eax, 256; TODO2: adding an element to a set
    PRINTF32 `%u\n\x0`, eax

    mov edx, eax;
    and edx, ebx; TODO3: intersection of the two sets
    PRINTF32 `%u\n\x0`, edx

    ; TODO4: the complement of a set
    mov edx, eax
    not edx
    PRINTF32 `%u\n\x0`, edx


    ; TODO5: removal of an element from a set
    mov edx, 1
    shl edx, 3
    not edx
    and eax, edx
    PRINTF32 `%u\n\x0`, eax


    ; TODO6: difference of two sets
    not ebx
    and eax, ebx
    PRINTF32 `%u\n\x0`, eax

    xor eax, eax
    ret
