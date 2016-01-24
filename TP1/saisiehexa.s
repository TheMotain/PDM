.data
UnNombre:
    .space 10
.text
.globl _start
_start:
    movq $3 , %rax
    movq $0 , %rbx
    movq $10 , %rdx
    movq $UnNombre , %rcx
    int $0x80
    
    movq $0 , %rdx
    movb UnNombre , %dl
    movq $UnNombre , %rcx
    
    movq $0 , %rax
    movq $48 , %r10
    movq $10 , %r11

while:
    cmp $10 , %rdx
    je prepareToString
    cmp $0 , %rdx
    je prepareToString

    movq %rdx , %r9

    imul %r11
    sub %r10 , %r9
    add %r9 , %rax

    incq %rcx
    movq $0 , %rdx
    movb (%rcx) , %dl
    jmp while

prepareToString:
    movq $10,%rdx

toString:
    cmp $0 , %rax
    je end
    
    shr $2, %rdx 
    movq %rdx,%r9

    idiv %r11
    add %r10, %rdx

    or %r9,%rdx
    jmp toString

end:
    movq $0 , %rbx
    movq $1 , %rax
    int $0x80
