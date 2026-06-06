; char *ft_strcpy(char *dst, const char *src);
;   rdi -> dst
;   rsi -> src
;   rax <- dst (return value)

section .text
	global ft_strcpy

ft_strcpy:
	xor		rcx, rcx ; i
.loop:
	mov		al, byte [rsi + rcx]    ; al = src[rcx]
	mov		byte [rdi + rcx], al    ; dst[rcx] = al
	test	al, al                  ; al == 0 ?
	jz		.done ; jump if zero, zeroフラグが立っていたら.done
	inc		rcx
	jmp		.loop
.done:
	mov		rax, rdi                ; return dst
	ret
