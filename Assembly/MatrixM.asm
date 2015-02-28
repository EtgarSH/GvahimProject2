;------------------------------------------
; File   :  Matrix.asm
; Author :  Etgar Shmueli
; Date   :  28/02/15
;------------------------------------------

macro NewMatrix Location, Rows, Columns
	push bx
	push ax
	push cx
	
	mov bx, Location
	mov al, Rows
	mov cl, Columns
	call NewMatrixProc
	
	pop cx
	pop ax
	pop bx
endm NewMatrix

include "MatrixP.asm"