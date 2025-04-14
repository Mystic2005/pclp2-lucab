; SPDX-License-Identifier: BSD-3-Clause

%include "printf32.asm"

extern printf

section .bss:
    ; the structure for a student
    struc student_t
        name:   resb	10	; char[10] - student name
        id_course:	resd	1	; integer - the id of the course where a student is assigned
        check:	resd	1	; "bool" - check if the student is assigned to any course
    endstruc

    ; the structure for a course
    struc course_t
        id:	resd	1	; id = index in courses (the list of courses)
        name_course:   resb	15	; char[10] - the name of the course
    endstruc

section .data
    unassigned:		db "Student unassigned :(", 0
    v_students_count:    dd 5
    v_courses_count:    dd 3

    students:
        istruc student_t
            at name,	db "Vlad", 0
            at id_course,		dd 0
            at check,	dd 1
        iend

        istruc student_t
            at name,	db "Andrew", 0
            at id_course,		dd 1
            at check,	dd 1
        iend

        istruc student_t
            at name,	db "Kim", 0
            at id_course,		dd 1
            at check,	dd 1
        iend

        istruc student_t
            at name,	db "George", 0
            at id_course,		dd 2
            at check,	dd 1
        iend

        istruc student_t
            at name,	db "Kate", 0
            at id_course,		dd 0
            at check,	dd 0
        iend

    courses:
        istruc course_t
            at id,	dd 0
            at name_course,	db "Assembly", 0
        iend

        istruc course_t
            at id,	dd 1
            at name_course,	db "Linear Algebra", 0
        iend

        istruc course_t
            at id,   dd 2
            at name_course,	db "Physics", 0
        iend

section .text
global main

main:
    push ebp
    mov ebp, esp
    PRINTF32 `The students list is:\n\x0`

    ; Initialize loop counter and pointers
    mov ecx, [v_students_count]    ; Number of students
    lea esi, [students]            ; Pointer to the students array

print_students:
    mov eax, [esi + student_t.check] ; Load the "check" field
    test eax, eax                    ; Check if the student is assigned to a course
    jz unassigned_student            ; If not assigned, jump to unassigned_student

    ; Print student name
    lea eax, [esi + student_t.name]  ; Load the address of the student's name
    push eax
    PRINTF32 `Student: %s\n\x0`
    add esp, 4

    ; Print course name
    mov eax, [esi + student_t.id_course] ; Load the course ID
    lea ebx, [courses]                   ; Pointer to the courses array
    imul eax, eax, course_t              ; Multiply course ID by the size of course_t
    add ebx, eax                         ; Add offset to the courses array
    lea eax, [ebx + course_t.name_course] ; Load the address of the course name
    push eax
    PRINTF32 `Course: %s\n\x0`
    add esp, 4
    jmp next_student

unassigned_student:
    ; Print unassigned message
    push unassigned
    PRINTF32 `%s\n\x0`
    add esp, 4

next_student:
    add esi, student_t                  ; Move to the next student
    loop print_students                 ; Repeat for all students

    leave
    ret