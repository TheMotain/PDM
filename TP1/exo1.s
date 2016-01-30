.data
	UnNombre : .space 10
.text
.globl _start
_start:

/* Saisie */
saisie:
	movq $3, %rax
	movq $0, %rbx
	movq $UnNombre, %rcx
	movq $10, %rdx
	int $0x80

	movq $0, %rdx
	movb UnNombre, %dl
	movq $UnNombre, %rcx

verif:
	/* Si on arrive au retour chariot ou bout de la mémoire */
	cmp $0, %rdx
	je fin
	cmp $10, %rdx
	je fin

	/* Si le caractère est supérieur à 64, c'est une lettre */
	cmp $64, %rdx
	jg lettre

chiffre:
	/* Si le caractère est inférieur à 48 (caractère '0'), on renvoie l'utilisateur à la saisie */
	cmp $48, %rdx 
	jl saisie

	/* Si le caractère est supérieur à 57 (caractère '9'), on renvoie l'utilisateur à la saisie */
	cmp $57, %rdx 
	jg saisie

	jmp inc

lettre:
	/* Si le caractère est supérieur à 102 (caractère 'f'), on renvoie l'utilisateur à la saisie */
	cmp $102, %rdx
	jg saisie

	/* Si le caractère est inférieur à 97 (caractère 'a'), c'est peut-être une majuscule */
	cmp $97, %rdx
	jl lettreMajuscule

	jmp inc

lettreMajuscule:
	/* Si le caractère est supérieur à 70 (caractère 'F'), on renvoie l'utilisateur à la saisie */
	cmp $70, %rdx
	jg saisie

inc:
	incq %rcx
	movq $0, %rdx
	movb (%rcx), %dl
	jmp verif

/* Fin */
fin:
	movq $0, %rbx
	movq $1, %rax
	int $0x80
