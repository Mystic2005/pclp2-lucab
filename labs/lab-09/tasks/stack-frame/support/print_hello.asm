; SPDX-License-Identifier: BSD-3-Clause

extern printf

section .data
	message db "Hello", 0

section .text

global print_hello

;   TODO: Add the missing instruction
print_hello:
	push ebp

	push message
	call printf
	add esp, 4

	leave
	ret
