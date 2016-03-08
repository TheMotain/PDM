.data
	format: .asciz "%ld\n"
.text
.global main

main:

	cmp $3, %rdi
	jne exit

	movq 8(%rsi), %r12
	movq 16(%rsi), %r13

	movq %r12, %rdi
	call atoi
	movq %rax, %r14

	movq %r13, %rdi
	call atoi
	movq %rax, %r15

	movq %r14, %rax
	movq $0, %rdx

	dec %r15

calcul:
	imul %r14
	dec %r15
	jnz calcul

fin:
	mov $format, %rdi
	mov %rax, %rsi
	xor %rax, %rax
	call printf

exit:
	movq $0, %rbx
	movq $1, %rax
	int $0x80
