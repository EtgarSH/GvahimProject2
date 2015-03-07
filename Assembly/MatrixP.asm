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

proc GetColumnsProc ; bx - offset. returns in cl - columns.
	GetLength bx
	ret
endp GetColumnsProc

proc GetRowsProc ; bx - offset. returns in al - rows
	push cx
	push bx
	
	GetLength bx
	xor ch, ch
	add bx, cx
	inc bx
	GetLength bx
	shr cl, 1
	mov al, cl
	
	pop bx
	pop cx
	
	ret
endp GetRowsProc

proc SetNodeProc ; bx - offset of matrix. ah - j. ch - i. dl - element
	push bx
	push si
	
	push ax
	GetElement bx, ch
	mov si, bx
	
	mov bh, al
	SetElement bx, ah, dl
	
	pop si
	pop bx
	
	ret
endp SetNodeProc

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