.data
	Text : .string "186AEaC1\n"
.text
.globl _start
_start:

/* Affichage */
affichage:
	movq $4, %rax
	movq $1, %rbx
	movq $Text, %rcx
	movq $10, %rdx
	int $0x80

/* Fin */
fin:
	movq $0, %rbx
	movq $1, %rax
	int $0x80
