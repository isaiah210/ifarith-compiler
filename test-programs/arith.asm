section .data
	int_format db "%ld",10,0


	global _main
	extern printf
section .text


_start:	call main
	mov rax, 60
	xor rdi, rdi
	syscall


main:	push rbp
	mov rbp, rsp
	sub rsp, 48
	mov esi, 5
	mov [rbp-16], esi
	mov esi, 3
	mov [rbp-8], esi
	mov edi, [rbp-8]
	mov eax, [rbp-16]
	mul eax, edi
	mov [rbp-16], eax
	mov esi, 8
	mov [rbp-24], esi
	mov edi, [rbp-24]
	mov eax, [rbp-16]
	sub eax, edi
	mov [rbp-16], eax
	mov esi, [rbp-16]
	lea rdi, [rel int_format]
	mov eax, 0
	call printf
finish_up:	add rsp, 48
	leave 
	ret 

