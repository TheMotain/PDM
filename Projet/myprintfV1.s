.global myPrintfASM
    .type myPrintfASM, @function
myPrintfASM:
    movq %rsi, Param
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

increment:
    incq %rdi
    movb (%rdi), %dl

    cmp $0, %dl
    je fin
    jmp boucle

fin:
    ret
