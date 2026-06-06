; int ft_strcmp(const char *s1, const char *s2);
;   rdi -> s1
;   rsi -> s2
;   eax <- difference (s1[i] - s2[i]) as unsigned char

section .text
	global ft_strcmp

ft_strcmp:
	xor		rcx, rcx ; i
.loop:
	movzx	eax, byte [rdi + rcx]   ; eax = (unsigned char)s1[i]
	movzx	edx, byte [rsi + rcx]   ; edx = (unsigned char)s2[i]
	cmp		al, dl
	jne		.diff                   ; jump if not equal
	test	al, al ; alがゼロかどうかをチェック
	jz		.done                   ; jump if zero, zeroフラグが立っていたら.done
	inc		rcx
	jmp		.loop
.diff:
	sub		eax, edx                ; eax -= edx
.done:
	ret

;  │ mov     │ 単純コピー                               │ mov rax, rbx          │
;  │ movzx   │ コピー+上位をゼロ埋め（unsigned拡張）   │ movzx eax, byte [rdi] │
;  │ movsx   │ コピー+符号拡張（signed拡張）           │ movsx eax, byte [rdi] │
;  │ xor     │ XOR 演算（同値同士でゼロ化に使う）       │ xor rax, rax          │
;  │ cmp     │ 引き算してフラグだけ残す                 │ cmp al, dl            │
;  │ test    │ AND してフラグだけ残す（ゼロ判定に使う） │ test al, al           │
;  │ sub     │ 引き算（結果を残す）                     │ sub eax, edx          │
;  │ inc     │ +1                                       │ inc rcx               │
;  │ je / jz │ フラグがゼロならジャンプ                 │ jz .done              │
;  │ jne     │ フラグが非ゼロならジャンプ               │ jne .diff             │
;  │ jmp     │ 無条件ジャンプ                           │ jmp .loop             │
;  │ ret     │ 関数から戻る                             │ ret                   │
