%include "printf32.asm"

%define NUM 5

section .text

extern printf
global main
main:
    mov ebp, esp

    ; TODO 1: replace every push by an equivalent sequence of commands (use direct addressing of memory. Hint: esp)
    mov ecx, NUM
pushn:
    sub esp, 4
    mov dword [esp], ecx
    loop pushn

    sub esp, 4
    mov dword [esp], 0
    sub esp, 4
    mov dword [esp], "corn"
    sub esp, 4
    mov dword [esp], "has "
    sub esp, 4
    mov dword [esp], "Bob "

    lea esi, [esp]
    PRINTF32 `%s\n\x0`, esi

    ; TODO 2: print the stack in "address: value" format in the range of [ESP:EBP]
    ; use PRINTF32 macro - see format above
    mov eax, ebp
prints:
    PRINTF32 `0x%x: 0x%x\n\x0`, eax, [eax]

    sub eax, 4
    cmp eax, esp
    jge prints

    ; TODO 3: print the string
    lea esi, [esp]
    PRINTF32 `%s\n\x0`, esi

    ; TODO 4: print the array on the stack, element by element.
    add esp, 16
    mov eax, esp
printa:
    PRINTF32 `%d \x0`, [eax]

    add eax, 4
    cmp eax, ebp
    jl printa
    PRINTF32 `\n\x0`
    
    ; restore the previous value of the EBP (Base Pointer)
    mov esp, ebp

    ; exit without errors
    xor eax, eax
    ret
