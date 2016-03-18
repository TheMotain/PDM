    .data
Caract:
    .quad 0
Decimales:
    .quad 0
Param:
    .quad 0

    .text

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
    movq Param, %rax
    movq $0, %rdx

boucleD1:   
    idivq %r10
    
    push %rdx
    incq Decimales

    cmp $0, %rax
    je boucleD2
    
    movq $0, %rdx
    jmp boucleD1

boucleD2:
    cmp $0, Decimales
    je finD
    pop Caract
    add $48, Caract
    call myPrintfChar
    
    decq Decimales
    jmp boucleD2

finD:
    ret

    .global myPrintfString
    .type myPrintfString, @function
myPrintfString:
    movq Param, %r8
    movb (%r8), %dl
    cmp $0, %dl
    je finS

    movb %dl, Caract
    call myPrintfChar

    incq Param
    jmp myPrintfString

finS:
    ret

    .global myPrintfHexa
    .type myPrintfHexa, @function
myPrintfHexa:
    movq Param, %r8
    movq %r8, %rax
    movq $0, %rdx

boucleH:
    cmp $0, %rax
    je finH

    idiv $16
    cmp $9, %rax
    jg affiche_lettre
    jmp affiche_chiffre

affiche_lettre:
    sub %rax, $9
    add %rax, $96

    jmp boucleH

jmp affiche_chiffre:
    jmp boucleH

finH:
    ret


    .global myPrintfASM
    .type myPrintfASM, @function
myPrintfASM:
    movq (%rsi),%r8
    movq %r8, Param
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

    cmp $'x', %dl
    je printHexa
    
    decq %rdi
    movb (%rdi), %dl
    movq $'%', Caract
    call myPrintfChar
    jmp increment

printChar:
    movq Param, %r8
    movq %r8, Caract
    call myPrintfChar
    jmp increment

printDeci:
    call myPrintfDecimal
    jmp increment

printString:
    call myPrintfString
    jmp increment

printHexa:
    call myPrintfHexa
    jmp increment

increment:
    addq $8, %rsi
    movq (%rsi),%r8
    movq %r8, Param
    incq %rdi
    movb (%rdi), %dl

    cmp $0, %dl
    je fin
    jmp boucle

fin:
    ret
