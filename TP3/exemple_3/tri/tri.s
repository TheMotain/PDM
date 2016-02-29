/*
 * File: tri.s
 */

        .data
saut:   .byte
msg1:   .asciz "<<"
msg2:   .asciz ">>"
format: .asciz "%s\n"
pform:  .asciz "%d"
        .bss
        .lcomm list, 1024
        .text
        .global main

main:
# Afficher <<
    
    mov $format, %rdi
    mov $msg1, %rsi
    call printf
    addl $4, %esp

# Saisir entiers
    
    pushq $list
    call saisir
    addl $4, %esp
    pushq %rax

# Afficher >>

    pushq $msg2
    call printf
    addl $4, %esp

# trier list

    pushq $list
    call trier
    addl $4, %esp

# Afficher list

    popq %rcx
    movl $0, %esi

aff_elem:
    
    movl list(,%esi,4), %eax
    pushq %rsi
    pushq %rcx
    pushq %rax
    pushq $pform
    call printf
    addl $8, %esp
    popq %rcx
    popq %rsi
    incl %esi

    loop aff_elem

# Saut de ligne

    pushq $saut
    call printf
    addl $4,%esp

exit:
    movl $0, %ebx
    movl $1, %eax
    int $0x80

