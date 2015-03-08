;------------------------------------------
; File   :  Matrix.asm
; Author :  Etgar Shmueli
; Date   :  28/02/15
;------------------------------------------

macro NewMatrix matrix, rows, columns
	push bx
	push ax
	
	mov bx, matrix
	mov ah, rows
	mov al, columns
	
	call NewMatrixProc
	
	pop ax
	pop bx
endm NewMatrix

macro GetColumns Matrix ; return in al
	push bx
	
	mov bx, Matrix
	call GetColumnsProc
	
	pop bx
endm GetColumns

macro GetRows Matrix ; returns in ah
	push bx
	
	mov bx, Matrix
	call GetRowsProc
	
	pop bx
endm GetRows

macro GetNode Matrix, i, j ; return in al
	push si
	push ax
	push cx
	push dx
	
	mov si, Matrix
	mov ch, i
	mov dh, j
	call GetNodeProc
	
	pop dx
	pop cx
	pop ax
	pop si
endm GetNode

macro SetNode Matrix, i, j, Element
	push si
	push ax
	push cx
	push dx
	
	mov si, Matrix
	mov ch, i
	mov dh, j
	mov dl, Element
	call SetNodeProc
	
	pop dx
	pop cx
	pop ax
	pop si
endm SetNode

macro PrintMatrix Matrix
	push bx
	
	mov bx, Matrix
	call PrintMatrixProc
	
	pop bx
endm PrintMatrix

macro PrintMatrix Matrix
	push si
	mov si, Matrix
	call PrintMatrixProc
	pop si
endm PrintMatrix

;include "MatrixP.asm"