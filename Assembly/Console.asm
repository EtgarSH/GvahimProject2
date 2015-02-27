;------------------------------------------
; File   :  Console.asm
; Author :  Etgar Shmueli
; Date   :  25/02/15
;------------------------------------------

proc Write ; dl is the character to print
	push ax
	
	mov ah, 2
	int 21h
	
	pop ax
	ret
endp Write

proc WriteSeq ; dx is the offset of string
	push ax
	
	mov ah, 9
	int 21h
	pop ax
	
	ret
endp WriteSeq

proc WriteLine ; dx is the offset of string
	push ax
	
	push dx
	mov dl, 10
	call Write
	pop dx
	
	mov ah, 9
	int 21h
	pop ax
	ret
endp WriteLine

proc ReadLine ; dx - offset of buffer
	push ax
	push dx
	
	mov ah, 10
	int 21h
	
	mov dl, 10
	call Write
	
	pop dx
	pop ax
	ret
endp ReadLine

proc ReadKey ; returns in al the key ASCII code
	push dx
	push ax
	
	mov dl, 10
	call Write
	
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
endp ReadKey

proc EnterVGAMode
	push ax
	
	mov ax, 012h
	int 10h
	
	pop ax
	ret
endp EnterVGAMode

proc SetBackgroundColor ; bl - Color
	push ax
	push bx
	
	mov ah, 0bh
	xor bh, bh

	int 10h
	
	pop bx
	pop ax
	ret
endp SetBackgroundColor