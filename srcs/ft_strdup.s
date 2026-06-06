; char *ft_strdup(const char *s);
;   rdi -> s
;   rax <- malloc されたコピー (失敗時 NULL, errno=ENOMEM は malloc が設定)

section .text
	global ft_strdup
	extern ft_strlen
	extern ft_strcpy
	extern malloc

ft_strdup:
	push	rbx                          ; 元のrbxの値をスタックに退避
	mov		rbx, rdi                     ; s を rbx に退避

	call	ft_strlen                    ; rax = strlen(s)
	lea		rdi, [rax + 1]               ; rdi = len + 1 (NUL 分), malloc の引数を準備
	call	malloc wrt ..plt             ; rax = malloc(len + 1)
	test	rax, rax
	jz		.done                        ; NULL なら errno は malloc 側で設定済, 0なら.done

	mov		rdi, rax                     ; dst = malloc ptr
	mov		rsi, rbx                     ; src = 元の s
	call	ft_strcpy                    ; rax = dst (= malloc ptr), ft_strcpy(rdi, rsi). ft_strcpy(dst, src)
.done:
	pop		rbx ; スタックからrbxに取り出す
	ret
