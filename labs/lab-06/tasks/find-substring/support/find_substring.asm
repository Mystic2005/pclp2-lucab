; SPDX-License-Identifier: BSD-3-Clause

%include "printf32.asm"

section .data
source_text: db "ABCABCBABCBABCBBBABABBCBABCBAAACCCB", 0 ; DO NOT MODIFY THIS LINE EXCEPT FOR THE STRING IN QUOTES
substring: db "BABC", 0 ; DO NOT MODIFY THIS LINE EXCEPT FOR THE STRING IN QUOTES

print_format: db "Substring found at index: %d", 10, 0

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    ; Initialize pointers and counters
    lea esi, [source_text]       ; Load address of source_text into esi
    lea edi, [substring]         ; Load address of substring into edi
    xor ecx, ecx                 ; Clear ecx (used for the current index in source_text)

find_next_occurrence:
    mov ebx, edi                 ; Load address of substring into ebx
    mov edx, esi                 ; Load current position in source_text into edx

compare_chars:
    mov al, [edx]                ; Load current character from source_text
    mov bl, [ebx]                ; Load current character from substring
    test al, al                  ; Check if end of source_text is reached
    jz end_search                ; If zero, end the search
    test bl, bl                  ; Check if end of substring is reached
    jz substring_found           ; If zero, substring is found
    cmp al, bl                   ; Compare characters
    jne next_char                ; If not equal, move to the next character
    inc edx                      ; Increment source_text pointer
    inc ebx                      ; Increment substring pointer
    jmp compare_chars            ; Continue comparing

next_char:
    inc esi                      ; Increment source_text pointer
    inc ecx                      ; Increment index counter
    jmp find_next_occurrence     ; Restart search from the next character

substring_found:
    push ecx                     ; Push the current index onto the stack
    push print_format            ; Push the print format string
    call printf                  ; Call printf to print the index
    add esp, 8                   ; Clean up the stack
    inc esi                      ; Move to the next character in source_text
    inc ecx                      ; Increment index counter
    jmp find_next_occurrence     ; Continue searching for the next occurrence

end_search:
    leave
    ret