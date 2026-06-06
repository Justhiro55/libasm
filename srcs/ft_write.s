; ssize_t ft_write(int fd, const void *buf, size_t count);
;   rdi -> fd
;   rsi -> buf
;   rdx -> count
;   rax <- bytes written (or -1 on error, errno set)

section .text
	global ft_write
	extern __errno_location              ; glibc の関数。&errno を返す

ft_write:
	mov		rax, 1                       ; Linux syscall: write
	syscall
	test	rax, rax
	js		.error                       ; rax < 0 ならエラー (rax = -errno)
	ret
.error:
	neg		rax                          ; -errno → errno
	push	rax                          ; errno 値をスタックに退避
	call	__errno_location wrt ..plt   ; rax = &errno
	pop		qword [rax]                  ; *errno_ptr = errno 値
	mov		rax, -1
	ret
