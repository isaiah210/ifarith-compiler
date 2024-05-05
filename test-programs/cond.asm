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
	sub rsp, 240
	mov esi, true
	mov [rbp-72], esi
	mov esi, [rbp-72]
	mov [rbp-112], esi
	mov esi, false
	mov [rbp-48], esi
	mov esi, [rbp-48]
	mov [rbp-120], esi
	mov esi, 0
	mov [rbp-24], esi
	mov edi, [rbp-24]
	mov eax, [rbp-120]
	cmp eax, edi
	mov [rbp-120], eax
	jz lab1272
	jmp lab1274
lab1272:	mov esi, 1
	mov [rbp-32], esi
	mov esi, [rbp-32]
	lea rdi, [rel int_format]
	mov eax, 0
	call printf
	mov rax, 0
	jmp finish_up
lab1274:	mov esi, 0
	mov [rbp-40], esi
	mov edi, [rbp-40]
	mov eax, [rbp-112]
	cmp eax, edi
	mov [rbp-112], eax
	jz lab1275
	jmp lab1277
lab1275:	mov esi, 2
	mov [rbp-16], esi
	mov esi, [rbp-16]
	lea rdi, [rel int_format]
	mov eax, 0
	call printf
	mov rax, 0
	jmp finish_up
lab1277:	mov esi, 0
	mov [rbp-64], esi
	mov esi, [rbp-64]
	lea rdi, [rel int_format]
	mov eax, 0
	call printf
	mov rax, 0
	jmp finish_up
finish_up:	add rsp, 240
	leave 
	ret 

