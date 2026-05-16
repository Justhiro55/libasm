; size_t ft_strlen(const char *s);
;   rdi -> s
;   rax <- length of s

; ↑ 中身はただのメモで機械語には影響しない．
; 関数のレジスタの使い方を最初に書いておく監修
; 入力レジスタ / 出力レジスタのメモ

section .text
	global _ft_strlen

; 実行ファイルの中身は各セクションに分かれている
; .text <- 実行コード. 関数本体
; .data <- 初期化付きのグローバル変数，等々

_ft_strlen:
	xor		rax, rax
	; 0初期化の時はこの書き方で初期化が慣習
	; 0以外はmovを使うがxor使う方が処理が早い
	; ちなみにmovの書き方は mov dest, value
.loop:
	cmp		byte [rdi + rax], 0
	; byte は「メモリから何バイト読むか」のサイズ指定
	je		.done
	; Jump if Equeal
	inc		rax
	jmp		.loop
.done:
	ret
	; return



; ->Written in C, this would look like:
; size_t  ft_strlen(const char *s)
;{
;	size_t  rax = 0;        // xor rax, rax
;loop:
;	if (s[rax] == 0)         // cmp byte [rdi+rax], 0
;		goto done;           // je .done
;	rax++;                   // inc rax
;	goto loop;               // jmp .loop
;done:
;	return rax;              // ret
;}
;*/
