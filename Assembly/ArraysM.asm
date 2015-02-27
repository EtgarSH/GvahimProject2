;------------------------------------------
; File   :  Arrays.asm
; Author :  Etgar Shmueli
; Date   :  25/02/15
;------------------------------------------

macro GetLength Array; returns length in cl
	push bx
	
	mov bx, Array
	call GetLength
	
	pop bx
endm GetLength

macro AddElement Array, Element
	push dx
	push bx

	mov bx, Array
	mov dl, Element
	call AddElement

	pop bx
	pop dx
endp AddElement

macro Sort Array
	push bx
	
	mov bx, Array
	call BubbleSort
	
	pop bx
endm Sort

macro Sum Array ; returns in al the sum of the array
	push bx
	
	mov bx, Array
	call sumProc
	
	pop bx
endm Sum

; Write the average and print array macros...

include "ArraysP.asm"