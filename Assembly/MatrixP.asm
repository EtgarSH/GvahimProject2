;------------------------------------------
; File   :  Matrix.asm
; Author :  Etgar Shmueli
; Date   :  28/02/15
;------------------------------------------

;include "ArraysM.asm"
dataseg
	toSend dw 0
codeseg

proc NewMatrixProc ; bx - matrix. ah - rows. al - columns.
	push dx
	push di
	push bx
	push ax

	shl ah, 1
	NewArray bx, ah ; pointers array
	mov di, bx ; save the pointers array offset
	add bl, ah
	inc bx
	shr ah, 1
	
	mov cl, ah
	xor ch, ch
RowsCreation:
	NewArray bx, al
	
	push cx
	
	push ax
	sub ah, cl
	mov cl, ah
	pop ax
	
	shl cl, 1
	
	push dx
	
	mov dl, bh
	push bx
	mov bx, di
	call SetElementProc ; set higher offset
	pop bx
	
	inc cl
	
	mov dl, bl
	push bx
	mov bx, di
	call SetElementProc ; set lower offset
	pop bx
	
	pop dx
	
	pop cx
	add bl, al
	inc bx
	loop RowsCreation
	
	pop ax
	pop bx
	pop di
	pop dx
	
	ret
endp NewMatrixProc

proc GetRowsProc ; bx - matrix. Signs in ah solution.
	push bx
	push cx
	
	GetLength bx
	shr cl, 1
	mov ah, cl
	
	pop cx
	pop bx
	ret
endp GetRowsProc

proc GetColumnsProc ; bx - matrix. Signs in al solution.
	push bx
	push cx
	push ax
	
	call GetRowsProc
	shl ah, 1
	add bl, ah
	inc bx
	inc bx
	
	
	GetLength bx
	pop ax
	mov al, cl
	
	pop cx
	pop bx
	ret
endp GetColumnsProc

proc GetNodeProc; di - matrix. ch - i. dh - j
	push cx

	shl ch, 1
	mov cl, ch
	mov bx, di
	call GetElementProc
	mov [byte ptr toSend+1], al
	inc cl
	call GetElementProc
	mov [byte ptr toSend], al
	
	mov si, [word ptr toSend]
	
	push bx
	mov bx, si
	call GetElementProc
	pop bx
	
	pop cx
	
	ret
endp GetNodeProc

proc SetNodeProc ; di - matrix. ch - i. dh - j. dl - Element.
	push bx
	push cx

	shl ch, 1
	mov cl, ch
	mov bx, di
	call GetElementProc
	mov [byte ptr toSend+1], al
	inc cl
	call GetElementProc
	mov [byte ptr toSend], al
	
	mov si, [word ptr toSend]
	
	mov bx, si
	mov cl, dh
	call SetElementProc
	
	pop cx
	pop bx
	ret
endp SetNodeProc