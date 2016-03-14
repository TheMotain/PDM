    .data
Caract:
    .quad 0
Decimales:
    .quad 0

    .text

    .global myPrintfASM
    .type myPrintfASM, @function
myPrintfASM:
    movb (%rdi), %dl

    cmp $0, %dl
    je fin

boucle:
    movb %dl, Caract
    cmp $'%', Caract
    je format

    call myPrintfChar

    incq %rdi
    movb (%rdi), %dl

    cmp $0, %dl
    je fin
    jmp boucle

format:
    incq %rdi
    movb (%rdi), %dl
    
    cmp $'c', %dl
    je printChar

    cmp $'d', %dl
    je printDeci

    cmp $'s', %dl
    je printString
    
    decq %rdi
    movb (%rdi), %dl
    movq $'%', Caract
    call myPrintfChar
    jmp increment

printChar:
    movq %rsi, Caract
    call myPrintfChar
    jmp increment

printDeci:
    call myPrintfDecimal
    jmp increment

printString:
    call myPrintfString
    jmp increment

increment:
    incq %rdi
    movb (%rdi), %dl

    cmp $0, %dl
    je fin
    jmp boucle

fin:
    ret

    .global myPrintfChar
    .type myPrintfChar, @function
myPrintfChar:
    movq $4, %rax
    movq $1, %rbx
    movq $Caract, %rcx
    movq $1, %rdx
    int $0x80
    ret

    .global myPrintfDecimal
    .type myPrintfDecimal, @function
myPrintfDecimal:
    movq $0, Decimales
    movq $10, %r10
    movq %rsi, %rax
    movq $0, %rdx

boucle1:   
    idivq %r10
    
    push %rdx
    incq Decimales

    cmp $0, %rax
    je boucle2
    
    movq $0, %rdx
    jmp boucle1

boucle2:
    cmp $0, Decimales
    je finD
    pop Caract
    add $48, Caract
    call myPrintfChar
    
    decq Decimales
    jmp boucle2

finD:
    ret

    .global myPrintfString
    .type myPrintfString, @function
myPrintfString:
    movb (%rsi), %dl
    cmp $0, %dl
    je finS

    movb %dl, Caract
    call myPrintfChar

    incq %rsi
    jmp myPrintfString

finS:
    ret
