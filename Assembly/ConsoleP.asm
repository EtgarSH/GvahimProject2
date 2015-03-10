;------------------------------------------
; File   :  ConsoleProc.asm
; Author :  Etgar Shmueli
; Date   :  25/02/15
;------------------------------------------

proc WriteProc ; dl is the character to print
	push ax
	
	mov ah, 2
	int 21h
	
	pop ax
	ret
endp WriteProc

proc WriteSeqProc ; dx is the offset of string
	push ax
	
	mov ah, 9
	int 21h
	pop ax
	
	ret
endp WriteSeqProc

proc WriteLineProc ; dx is the offset of string
	push ax
	
	push dx
	pop dx
	
	mov ah, 9
	int 21h
	pop ax
	ret
endp WriteLineProc

proc ReadLineProc ; dx - offset of buffer
	push ax
	push dx
	
	mov ah, 10
	int 21h
	
	mov dl, 10
	call WriteProc
	
	pop dx
	pop ax
	ret
endp ReadLineProc

proc ReadKeyProc ; returns in al the key ASCII code
	push dx
	push ax
	
	mov ah, 8
	int 21h
	
	mov bp ,sp
	sub bp, 2
	mov [bp], cx
	mov cl, al
	
	pop ax
	
	mov al, cl
	mov cx, [bp]
	pop dx
	ret
endp ReadKeyProc

proc ReadKey_show_charProc ; returns in al the key ASCII code
	push dx
	push ax
	mov ah,1h
	int 21h
	mov dl,al
	pop ax
	mov al,dl
	pop dx
	ret
endp ReadKey_show_charProc

proc EnterVGAModeProc
	push ax
	
	mov ax, 012h
	int 10h
	
	pop ax
	ret
endp EnterVGAModeProc

proc SetBackgroundColorProc ; bl - Color
	push ax
	push bx
	
	mov ah, 0bh
	xor bh, bh

	int 10h
	
	pop bx
	pop ax
	ret
endp SetBackgroundColorProc