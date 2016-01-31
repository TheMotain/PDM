.data
NombreSaisie:
    .space 10
TailleMax:
    .quad 10
TailleSaisie:
    .quad 0
.text
.globl _start
_start:

/* Saisie */
saisie:
    movq $3 , %rax
    movq $0 , %rbx
    movq $NombreSaisie , %rcx
    movq TailleMax , %rdx
    int $0x80

    movq $0 , %rax
    movq $0 , %rdx
    movb NombreSaisie , %dl
    movq $NombreSaisie , %rcx

    /* Si on commence par un retour chariot ou marqueur de fin */
    cmp $'.' , %rdx
    je fin
    cmp $'\n' , %rdx
    je fin

verif:
    /*Si le caractère est supérieur à 64 c'est une lettre */
    cmp $'A' , %rdx
    jge lettre

chiffre:
    /* Si le caractère est inférieur à 48 (caractère '0'), on renvoie l'utilisateur à la saisie */
    cmp $'0' , %rdx
    jl saisie

    /* Si le caractère est supérieur à 57 (caractère '9'), on renvoie l'utilisateur à la saisie */
    cmp $'9' , %rdx
    jg saisie

    /* traduit le premier caractère en un entier hexadecimal */
    subb $'0' , %dl
    jmp inc

/* Pour chacun des trois cas suivant on soustrait la valeur du code ascii 
 * du point 0 (48 pour les chiffres, 55 pour les majuscules et 87 pour 
 * les minuscules) afin d'obtenir la bonne valeur hexadécimale */

lettre:
    /* Si le caractère est supérieur à 102 (caractère 'f'), on renvoie l'utilisateur à la saisie */
    cmp $'f' , %rdx
    jg saisie

    /* Si le caractère est inférieur à 97 (caracctère 'a'), c'est peut-être une majuscule */
    cmp $'a' , %rdx
    jl lettreMajuscule
    
    subb $87 , %dl
    jmp inc

lettreMajuscule:
    /* Si le caractère est supérieur à 70 (caractère 'F'), on renvoie l'utilisateur à la saisie */
    cmp $'F' , %rdx
    jg saisie

    subb $55 , %dl

inc:
    /* Ou binaire pour concaténer le chiffre hexa en cours de lecture au nombre final*/
    orb %dl , %al
    incq TailleSaisie

    incq %rcx
    movq $0 , %rdx
    movb (%rcx), %dl

    /* Vérification si la fin de chaine a été atteinte */
    cmp $'.' , %rdx
    je fin
    cmp $'\n' , %rdx
    je fin

    /* décalage de l'entier vers la gauche pour pouvoir concaténer la prochaine valeur */
    shl $4 , %rax
    jmp verif

/* Fin */
fin:
    movq $0 , %rbx
    movq $1 , %rax
    int $0x80
