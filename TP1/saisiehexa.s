.data
/* Buffer d'entrée */
NombreSaisie:
    .space 10
/* Buffer de sortie */
NombreAffichage:
    .rept 10
    .quad 0
    .endr
/* Taille Max du Buffer */
TailleMax:
    .quad 10
/* Taille de la Saisie */
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
    je transformation_ascii
    cmp $'\n' , %rdx
    je transformation_ascii

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
    je transformation_ascii
    cmp $'\n' , %rdx
    je transformation_ascii

    /* décalage de l'entier vers la gauche pour pouvoir concaténer la prochaine valeur */
    shl $4 , %rax
    jmp verif

/* transformation de l'entier en une chaine de charactères ascii*/
transformation_ascii:
    /* initialisation de la chaine ascii en partant par la fin */
    /* curseur */
    movq $1 , %r8
    movq $NombreAffichage , %rcx
    movq $'\n' , (%rcx)
    incq %rcx

transformation:
    /* La lecture de l'entier est elle finie */
    cmp $0 , %rax
    je inverse_tableau
    
    /* mise en place d'un masque pour récupérer l'entier exa chiffre par chiffre*/
    movb $0x0f , %bl
    andb %al , %bl
    /* Si le chiffre hexa est un chiffre ou une lettre */
    cmp $9 , %bl
    jg transformation_lettre
    jmp transformation_chiffre

/* ajout de l'entier correspondant au caractère ascii */
transformation_lettre:
    movb $55 , %r9b
    jmp ascii

transformation_chiffre:
    movb $'0' , %r9b

/* ajout du caractère ascii calculé dans la chaine de caractère */
ascii:
    addb %r9b , %bl
    movq %rbx , (%rcx)
    incq %rcx
    /* incrémentation du curseur et déplacement de l'entier afin de prendre les 4 bits suivants */
    incq %r8
    shr $4 , %rax
    jmp transformation

/* le tableau de caractère étant inversé il nécessite d'être remis dans le bon sens */
inverse_tableau:
    movq $NombreAffichage , %rcx
    movq $1 , %rdx

/* On enpile tous les caractères du tableau jusque atteindre la fin de la chaine */
empile_tableau:
    cmp %r8 , %rdx
    je pre_depile_tableau
    push (%rcx)
    incq %rcx
    incq %rdx
    jmp empile_tableau

/* On repose le tableau au début */
pre_depile_tableau:
    movq $NombreAffichage , %rcx

/* on dépile le tableau jusqu'à ce que la chaine soit reconstruite */
depile_tableau:
    cmp $0 , %rdx
    je affichage
    pop (%rcx)
    incq %rcx
    decq %rdx
    jmp depile_tableau

/* Affichage de l'entier */
affichage:
    movq $4 , %rax
    movq $1 , %rbx
    movq $NombreAffichage , %rcx
    movq TailleSaisie , %rdx
    int $0x80

/* Fin */
fin:
    movq $0 , %rbx
    movq $1 , %rax
    int $0x80
