;------------------------------------------
; File   :  Matrix.asm
; Author :  Etgar Shmueli
; Date   :  28/02/15
;------------------------------------------

include "ArraysM.asm"

proc NewMatrixProc ; bx - offset of matrix. al - rows. cl - columns.
	push cx
	push bx
	push di
	push si
	
	mov di, 0
	mov si, bx
	shl cl, 2 ; Mul by 2
	NewArray si, cl
	shr cl, 1 ; divide by 2
	add bx, cl
	inc bx
ArraysCreation:
	NewArray bx, al
	SetWord si, di, bx
	
	inc di
	add bx, al
	inc bx
	
	loop ArraysCreation
	
	pop si
	pop di
	pop bx
	pop cx
	
	ret
endp NewMatrixProc

proc GetColumns ; bx - offset. returns in cl - columns.
	GetLength bx
	ret
endp GetColumns

proc GetRows ; bx - offset. returns in al - rows
	push cx
	push bx
	
	GetLength bx
	add bx, cl
	inc bx
	GetLength bx
	shr cl, 1
	mov al, cl
	
	pop bx
	pop cx
	
	ret
endp GetRows

proc GetNodeProc ; bx - offset of matrix. ah - i. ch - j. al - element.
	push bx
	
	push ax
	GetWord bx, ch
	mov bx, ax
	pop ax
	GetElement bx, ah
	
	pop bx
	
	ret
endp GetNodeProc