    .data
    .text
    .global main
main:
    movq $'t', %rdi
    call myPrintfChar
    ret

    .global myPrintfChar
    .type myPrintfChar, @function
myPrintfChar:
    movq $4, %rax
    movq $1, %rbx
    movq %rdi, %rcx
    movq $2, %rdx
    int $0x80
    ret

    
