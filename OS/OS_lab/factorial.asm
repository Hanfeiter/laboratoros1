	.file	"factorial.cpp"
	.text
	.globl	_Z19factorial_recursivei
	.def	_Z19factorial_recursivei;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z19factorial_recursivei
_Z19factorial_recursivei:
.LFB0:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	leaq	32(%rsp), %rbp
	.seh_setframe	%rbp, 32
	.seh_endprologue
	movl	%ecx, 32(%rbp)
	cmpl	$1, 32(%rbp)
	jg	.L2
	movl	$1, %eax
	jmp	.L3
.L2:
	movl	32(%rbp), %eax
	movslq	%eax, %rbx
	movl	32(%rbp), %eax
	subl	$1, %eax
	movl	%eax, %ecx
	call	_Z19factorial_recursivei
	imulq	%rbx, %rax
.L3:
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	ret
	.seh_endproc
	.globl	_Z19factorial_iterativei
	.def	_Z19factorial_iterativei;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z19factorial_iterativei
_Z19factorial_iterativei:
.LFB1:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	movq	$1, -8(%rbp)
	movl	$2, -12(%rbp)
	jmp	.L5
.L6:
	movl	-12(%rbp), %eax
	cltq
	movq	-8(%rbp), %rdx
	imulq	%rdx, %rax
	movq	%rax, -8(%rbp)
	addl	$1, -12(%rbp)
.L5:
	movl	-12(%rbp), %eax
	cmpl	16(%rbp), %eax
	jle	.L6
	movq	-8(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r3) 14.2.0"
