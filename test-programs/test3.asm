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
	sub rsp, 128
	mov esi, 5
	mov [rbp-32], esi
	mov esi, 3
	mov [rbp-24], esi
	mov esi, [rbp-32]
	mov [rbp-16], esi
	mov edi, [rbp-24]
	mov eax, [rbp-16]
	add eax, edi
	mov [rbp-16], eax
	mov esi, 0
	mov [rbp-40], esi
	mov edi, [rbp-40]
	mov eax, [rbp-16]
	cmp eax, edi
	mov [rbp-16], eax
	jz lab1271
	jmp lab1273
lab1271:	mov esi, 1
	mov [rbp-8], esi
	mov esi, [rbp-8]
	lea rdi, [rel int_format]
	mov eax, 0
	call printf
	mov rax, 0
	jmp finish_up
lab1273:	mov esi, 0
	mov [rbp-64], esi
	mov esi, [rbp-64]
	lea rdi, [rel int_format]
	mov eax, 0
	call printf
	mov rax, 0
	jmp finish_up
finish_up:	add rsp, 128
	leave 
	ret 

