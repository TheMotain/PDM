.data
Tab:
    .quad '2' , '5' , '+', '3' , '-' , '3' , '7' , '*' , '/' , '.'
TailleMax:
    .quad 10
.text
.globl _start
_start:
    movq $Tab , %rbx
    movq $48 , %r10

boucle:
    cmp $46 , %rbx
    je fin
    cmp $0 , TailleMax
    je fin

    cmp $48 , %rbx
    jl symbole
    cmp $57 , %rbx
    jg symbole

    sub %r10 , %rbx

    push %rax

symbole:
    cmp $43 , %rbx
    je add
    cmp $45 , %rbx
    je sous
    cmp $42 , %rbx
    je mult
    cmp $47 , %rbx
    je div

fin:
