.data
Tab:
    .quad '9' , '4' , '+', '3' , '-' , '2' , '5' , '*' , '/' , '.'
TailleMax:
    .quad 10
.text
.globl _start
_start:
    movq $Tab , %rcx
    movb (%rcx) , %bl
    movq $48 , %r10

boucle:
    cmp $'.' , %rbx
    je fin
    cmp $0 , TailleMax
    je fin

    cmp $48 , %rbx
    jl symbole
    cmp $57 , %rbx
    jg symbole

    sub %r10 , %rbx

    push %rbx

    add $8 , %rcx
    movb (%rcx) , %bl
    jmp boucle

symbole:
    pop %r8
    pop %rax
    cmp $43 , %rbx
    je add
    cmp $45 , %rbx
    je sous
    cmp $42 , %rbx
    je mult
    cmp $47 , %rbx
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
    idiv %r8
    push %rax

incre:
    addq $8 , %rcx
    movb (%rcx) , %bl
    jmp boucle

fin:
    pop %rdx
    movq $0 , %rbx
    movq $1 , %rax
    int $0x80
