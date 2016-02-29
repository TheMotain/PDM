    .data
    .text
    .global myPrintfChar
    .type myPrintfChar, @function
myPrintfChar:
    movq $4, %rax
    movq $1, %rbx
    movq %rdi, %rcx
    movq $1, %rdx
    int $0x80
    ret

    
