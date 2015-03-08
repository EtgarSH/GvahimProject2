;------------------------------------------
; File   :  Matrix.asm
; Author :  Etgar Shmueli
; Date   :  28/02/15
;------------------------------------------

;include "ArraysM.asm"

;proc NewMatrixProc ; bx - offset of matrix. al - rows. cl - columns.
;	push cx
;	push bx
;	push di
;	push si
;	push dx
;	
;	mov dl, 0
;	mov si, bx
;	
;	shl cl, 1 ; Mul by 2
;	NewArray si, cl
;	shr cl, 1 ; divide by 2
;	xor ch, ch
;	add bx, cx
;	inc bx
;ArraysCreation:
;	NewArray bx, al
;	SetElement si, dl, bh
;	inc si
;	SetElement si, dl, bl
;	dec si
;	
;	inc dl
;	xor ah, ah
;	add bx, ax
;	inc bx
;	
;	loop ArraysCreation
;	
;	pop dx
;	pop si
;	pop di
;	pop bx
;	pop cx
;	
;	ret
;endp NewMatrixProc

proc NewMatrixProc ; bx - matrix. ah - rows. al - columns.
	push dx
	push si
	push bx
	push ax

	shl ah, 1
	NewArray bx, ah ; pointers array
	mov si, bx ; save the pointers array offset
	add bl, ah
	inc bx
	shr ah, 1
	
	push cx
	mov cl, ah
	xor ch, ch
ColumnsCreation:
	NewArray bx, al
	
	push ax
	sub ah, cl
	shl ah, 1
	push cx
	mov ch, ah
	SetElement si, ch, bh
	inc ah
	mov ch, ah
	SetElement si, ah, bl
	pop cx
	pop ax
	
	add bl, al
	inc bx
	loop ColumnsCreation
	
	pop cx
	
	pop ax
	pop bx
	pop si
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

proc GetNodeProc ; si - matrix. ch - i. dh - j. Signs in al.
	push si
	push bx
	push cx
	push dx
	
	push ax
	
	shl ch, 1
	GetElement si, ch
	mov bh, al
	inc ch
	GetElement si, ch
	mov bl, al
	
	pop ax
	GetElement bx, dh
	
	pop dx
	pop cx
	pop bx
	pop si
	
	ret
endp GetNodeProc

proc SetNodeProc ; si - matrix. ch - i. dh - j. dl - Element.
	push si
	push bx
	push cx
	push dx
	
	push ax
	
	shl ch, 1
	GetElement si, ch
	mov bh, al
	inc ch
	GetElement si, ch
	mov bl, al
	
	pop ax
	SetElement bx, dh, dl
	
	pop dx
	pop cx
	pop bx
	pop si
	
	ret
endp SetNodeProc

proc PrintMatrixProc ; si - matrix
	push dx
	push ax
	push cx
	push bx
	
	mov bx, si
	call GetRowsProc
	xor ch, ch
	mov cl, ah
	mov dh, 0
RowsLoop:
	shl dh, 1
	GetElement si, dh
	mov bh, al
	inc dh
	GetElement si, dh
	mov bl, al
	inc dh
	shr dh, 1
	
	PrintArray bx
	
	loop RowsLoop
	
	pop bx
	pop cx
	pop ax
	pop dx
	
	ret
endp PrintMatrixProc
;proc PrintMatrixProc ; bx - offset
;	push ax
;	push cx
;	
;	call GetColumnsProc
;	call GetRowsProc
;	
;	mov ah, 0; i
;ColumnsLoop:
;	mov ch, 0; j
;RowsLoop:
;	call GetNodeProc
;	Write al
;	Write ' '
;
;	inc ch
;	cmp ch, cl
;	jnz RowsLoop
;	
;	Write 10
;	
;	inc ah
;	cmp ah, al
;;	jnz ColumnsLoop
;	
;	pop cx
;	pop ax
;	
;	ret
;endp PrintMatrixProc