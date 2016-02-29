	.file	"fib.c"
	.section	.rodata
.LC0:
	.string	"%ld\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$9, %edi
	call	fibonacci
	movq	%rax, %rsi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.globl	fibonacci
	.type	fibonacci, @function
fibonacci:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$24, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -24(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.L3
	movl	$0, %eax
	jmp	.L4
.L3:
	cmpq	$1, -24(%rbp)
	jne	.L5
	movl	$1, %eax
	jmp	.L4
.L5:
	movq	-24(%rbp), %rax
	subq	$1, %rax
	movq	%rax, %rdi
	call	fibonacci
	movq	%rax, %rbx
	movq	-24(%rbp), %rax
	subq	$2, %rax
	movq	%rax, %rdi
	call	fibonacci
	addq	%rbx, %rax
.L4:
	addq	$24, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	fibonacci, .-fibonacci
	.ident	"GCC: (Debian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
