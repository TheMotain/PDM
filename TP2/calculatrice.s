.data
Tab:
    .quad '9' , '4' , '+', '3' , '-' , '2' , '5' , '*' , '/' , '.'
TailleMax:
    .quad 10
.text
.globl main
main:
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
    movq %rbx, %rdx
    call repartir
    pop %rax
    pop %rax
    push %rsi

incre:
    addq $8 , %rcx
    movb (%rcx) , %bl
    jmp boucle

fin:
    movq %rsi, %rcx
    call print
    movq $0 , %rbx
    movq $1 , %rax
    int $0x80

.globl repartir
.type repartir, @function
repartir:
    push %rbp
    movq %rsp, %rbp

    cmp $43 , %rdx
    je add
    cmp $45 , %rdx
    je sous
    cmp $42 , %rdx
    je mult
    cmp $47 , %rdx
    je div

add:
    call additionner
    movq %rbp, %rsp
    pop %rbp
    ret

sous:
    call soustraire
    movq %rbp, %rsp
    pop %rbp
    ret

mult:
    call multiplier
    movq %rbp, %rsp
    pop %rbp
    ret

div:
    call diviser
    movq %rbp, %rsp
    pop %rbp
    ret

.globl multiplier
.type multiplier, @function
multiplier:
    push %rbp
    movq %rsp, %rbp

    movq 32(%rbp), %r8
    movq 40(%rbp), %rax
    imul %r8, %rax
    movq %rax, %rsi

    movq %rbp, %rsp
    pop %rbp
    ret

.globl diviser
.type diviser, @function
diviser:
    push %rbp
    movq %rsp, %rbp

    movq 32(%rbp), %r8
    movq 40(%rbp), %rax
    movq $0, %rdx
    idivq %r8
    movq %rax, %rsi

    movq %rbp, %rsp
    pop %rbp
    ret

.globl additionner
.type additionner, @function
additionner:
    push %rbp
    movq %rsp, %rbp

    movq 32(%rbp), %r8
    movq 40(%rbp), %rax
    add %r8, %rax
    movq %rax, %rsi

    movq %rbp, %rsp
    pop %rbp
    ret

.globl soustraire
.type soustraire, @function
soustraire:
    push %rbp
    movq %rsp, %rbp

    movq 32(%rbp), %r8
    movq 40(%rbp), %rax
    sub %r8,%rax
    movq %rax, %rsi
    
    movq %rbp, %rsp
    pop %rbp
    ret

.globl print
.type print, @function
print:
    push %rbp
    movq %rsp, %rbp

    mov $format, %rdi
    movq %rcx, %rsi
    call printf
    
    movq %rbp, %rsp
    pop %rbp
    ret

format:
    .asciz "%201d\n"
