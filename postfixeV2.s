.data
Fichier:
    .space 512
Destination:
    .string "resultat.txt"
Flag:
    .byte 00
Buffer:
    .rept 1
    .quad 0
    .endr
Size:
    .quad 1
.text
.globl _start
_start:
    movq $3 , %rax
    movq $0 , %rbx
    movq $Fichier , %rcx
    movq $512 , %rdx
    int $0x80

    decq %rax
    addq %rax , %rcx
    movb $0 , (%rcx)

chargement:
    mov $5 , %rax
    mov $Fichier , %rbx
    mov $0 , %rcx
    mov $0 , %rdx
    int $0x80
    mov %rax , %r9

lecture:
    mov $3 , %rax
    mov %r9 , %rbx
    mov $Buffer , %rcx
    mov Size , %rdx
    int $0x80
    movq %rbx , %r9

    movq $0 , %rbx
    movb (%rcx) , %bl
    movq $1 , %r11
    movq $'0' , %r10

boucle:
    cmp $'.' , %rbx
    je ecriture
    cmp $' ' , %rbx
    je incre
    cmp $0 , %rbx
    je incre

    cmp $'0' , %rbx
    jl symbole
    cmp $'9' , %rbx
    jg symbole

    sub %r10 , %rbx

    push %rbx

    cmp Size , %r11
    je lecture
    incq %r11
    add $8 , %rcx
    movb (%rcx) , %bl
    jmp boucle

symbole:
    pop %r8
    pop %rax
    cmp $'+' , %rbx
    je add
    cmp $'-' , %rbx
    je sous
    cmp $'*' , %rbx
    je mult
    cmp $'/' , %rbx
    je div

add:
    add %rax , %r8
    push %r8
    jmp incre

sous:
    sub %r8 , %rax
    push %rax
    jmp incre

mult:
    imul %r8 , %rax
    push %rax
    jmp incre

div:
    movq $0 , %rdx
    idiv %r8
    push %rax

incre:
    cmp Size , %r11
    je lecture
    addq $8 , %rcx
    movb (%rcx) , %bl
    incq %r11
    jmp boucle

ecriture:
    movq $6 %rax
    movq %r9 , %rbx
    int $0x80

    movq $8 , %rax
    movq $Resultat

fermeture:

fin:
    movq $0 , %rbx
    movq $1 , %rax
    int $0x80
