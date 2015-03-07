;------------------------------------------
; File   :  Matrix.asm
; Author :  Etgar Shmueli
; Date   :  28/02/15
;------------------------------------------

macro NewMatrix Location, Columns, Rows
	push cx
	push si

	shl Columns, 1
	NewArray Location, Columns
	mov si, Location
	Location = Location+Columns+1	
	shr Columns, 1
	
	local ArraysCreation
	mov cl, 0
ArraysCreation:
	NewArray Location, Rows
	SetElement si, cl, Location
	Location = Location + Rows + 1
	
	inc cl
	cmp cl, Columns
	jnz ArraysCreation
	
	pop si
	pop cx
endm NewMatrix
;macro NewMatrix Location, Rows, Columns
;	push bx
;	push ax
;	push cx
;	
;	mov bx, Location
;	mov al, Rows
;	mov cl, Columns
;	call NewMatrixProc
;	
;	pop cx
;	pop ax
;	pop bx
;endm NewMatrix

macro GetColumns Matrix ; return in cl
	push bx
	
	mov bx, Matrix
	call GetColumnsProc
	
	pop bx
endm GetColumns

macro GetRows Matrix
	push bx
	
	mov bx, Matrix
	call GetRowsProc
	
	pop bx
endm GetRows

;macro GetNode Matrix, i, j ; return in al
;	push bx
;	push ax
;	push cx
;	
;	mov bx, Matrix
;	mov ch, i
;	mov ah, j
;	call GetNodeProc
;	
;	pop cx
;	pop ax
;	pop bx
;endm GetNode

macro SetNode Matrix, i, j, Element
	push bx
	push ax
	push cx
	push dx
	
	mov bx, Matrix
	mov ch, i
	mov ah, j
	mov dl, Element
	call SetNodeProc
	
	pop dx
	pop cx
	pop ax
	pop bx
endm SetNode

macro PrintMatrix Matrix
	push bx
	
	mov bx, Matrix
	call PrintMatrixProc
	
	pop bx
endm PrintMatrix

macro GetNode Matrix, i, j ; return in al
	push bx
	push cx

	GetElement Matrix, i
	mov bh, al
	mov cl, i
	inc cl
	GetElement Matrix, cl
	mov bl, al
	
	GetElement bx, j
	
	pop cx
	pop bx
endm GetNode

macro PrintMatrix Matrix
	push ax
	push dx
	
	mov ah, 0 ; i
local RowsLoop:
	mov ch, 0 ; j
local ColumnsLoop:
	GetNode Matrix, ah, ch
	Write al
	add al, 30h
	Write ' '
	
	inc ch
	cmp ch, 4
	jnz ColumnsLoop
	
	Write 10
	
	inc ah
	cmp ah, 3
	jnz RowsLoop
	
	pop dx
	pop ax
endm PrintMatrix

;include "MatrixP.asm"