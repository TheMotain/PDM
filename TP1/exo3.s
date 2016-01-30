.data
Entier:
    .quad 0x186aeac1
EntierString:
    .rept 10
    .quad 0
    .endr
Taille:
    .quad 1
.text
.globl _start
_start:
    movq Entier , %rax
    mov $EntierString , %rcx
    movq $'\n' , (%rcx)
    incq %rcx

boucle:
    cmp $0 , %rax
    je inverse_tab
    movb $0x0f , %bl
    andb %al , %bl
    cmp $9 , %bl
    jg lettre
    jmp chiffre

lettre:
    movb $55 , %r8b
    jmp ascii

chiffre:
    movb $48 , %r8b

ascii:
    addb %r8b , %bl
    movq %rbx , (%rcx)
    incq %rcx
    incq Taille
    shr $4 , %rax
    jmp boucle

inverse_tab:
    mov $EntierString , %rcx
    movq $1 , %rdx

empile_tab:
    cmp Taille, %rdx
    je pre_depile_tab
    push (%rcx)
    incq %rcx
    incq %rdx
    jmp empile_tab

pre_depile_tab:
    mov $EntierString , %rcx

depile_tab:
    cmp $0 , %rdx
    je fin
    pop (%rcx)
    incq %rcx
    decq %rdx
    jmp depile_tab

fin:
    mov $EntierString , %rcx
    movq $1 , %rax
    movq $0 , %rbx
    int $0x80
