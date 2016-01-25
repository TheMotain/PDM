.data
UnNombre:
    .string "186AEaC1\n"
.text
.globl _start
_start:
    /* initialisation du curseur de lecture */
    movb UnNombre , %dl
    movq $UnNombre , %rcx

    /* est-on en fin de chaine ? */
    cmp $10 , %dl
    je fin

boucle:
    /* est-ce une lettre ? */
    cmp $65 , %dl
    jge lettre
    
    /* est-ce un chiffre ? */
    cmp $57 , %dl
    jle chiffre

lettre:
    /* majuscule ou minuscule ? */
    cmp $97 , %dl
    jl majus

/* pour chacun des trois cas suivant on soustrait la valeur code asciidu 
 * point 0 (48 pour les chiffre, 55 pour les majuscules et 87 pour les 
 * minusules) afin d'obtenir la bonne valeur numérique
 */
minus:
    subb $87 , %dl
    jmp insertion

majus:
    subb $55 , %dl
    jmp insertion

chiffre:
    subb $48 , %dl
    jmp insertion

insertion:
    /* ou binaire entre le résultat et la valeur à concat */
    orb %dl , %al
    
    /* incrémentation du curseur de lecture */
    incq %rcx
    movb (%rcx) , %dl
    
    /* vérification de fin de lecture */
    cmp $10 , %dl
    je fin
    
    /* décalage de la valeur vers la gauche pour ajouter la suite */
    shl $4 , %rax
    jmp boucle

fin:
    movq $1 , %rax
    movq $0 , %rbx
    int $0x80
