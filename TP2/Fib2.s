.data
Ordre:
    .quad 10
.global main
.text
main:
    mov Ordre,%rcx
    
    call fibonacci
    
    movq $0 , %rbx
    movq $1 , %rax
    int $0x80

.global fibonacci
.type fibonacci, @function
fibonacci:
    xor %rax, %rax
    xor %rbx, %rbx
    inc %rbx

fibonacci_boucle:
    push %rax
    push %rcx

    mov $format, %rdi
    mov %rax, %rsi
    xor %rax, %rax
    
    call printf

    pop %rcx
    pop %rax

    mov %rax,%rdx
    mov %rbx,%rax
    add %rdx, %rbx
    dec %rcx
    jnz fibonacci_boucle

end:
    ret

format:
    .asciz "%20ld\n"
