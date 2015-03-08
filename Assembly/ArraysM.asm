;------------------------------------------
; File   :  Arrays.asm
; Author :  Etgar Shmueli
; Date   :  25/02/15
;------------------------------------------

macro GetLength Array; returns length in cl
	push bx
	
	mov bx, Array
	call GetLengthProc
	
	pop bx
endm GetLength

macro NewArray Location, Len ; Location - of array
	push bx
	push cx
	
	mov bx, Location
	mov cl, Len
	call NewArrayProc
	
	pop cx
	pop bx
endm NewArray

macro ClearArray Array
	push bx
	
	mov bx, Array
	call ClearArrayProc
	
	pop bx
endm ClearArray

macro SetElement Array, Index, Elem
	push bx
	push si
	push dx
	push ax
	
		
	mov al, Index
	xor ah, ah
	mov si, ax
	mov dl, Elem
	mov bx, Array
	call SetElementProc
	
	pop ax
	pop dx
	pop si
	pop bx
endm SetElement

macro GetElement Array, Index; returns element in al
	push cx
	push bx
	
	mov bx, Array
	mov cl, Index
	call GetElementProc
	
	pop bx
	pop cx
endm GetElement

macro Sort Array
	push bx
	
	mov bx, Array
	call BubbleSort
	
	pop bx
endm Sort

macro Sum Array ; returns in al the sum of the array
	push bx
	
	mov bx, Array
	call SumProc
	
	pop bx
endm Sum

macro Average Array
	push bx
	
	mov bx, Array
	call AverageProc
	
	pop bx
endm Average

macro PrintArray Array
	push bx
	
	mov bx, Array
	call PrintArrayProc
	
	pop bx
endm PrintArray