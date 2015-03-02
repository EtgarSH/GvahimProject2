IDEAL
MODEL small
STACK 100h
DATASEG
	myArrayDS db 21 dup(?)
	myArray equ offset myArrayDS
CODESEG

include "ConsoleM.asm"
include "ArraysM.asm"

start:
	mov ax, @data
	mov ds, ax
	
	NewArray myArray, 20
	
	SetElement myArray, 0, 15
	PrintArray myArray
	
exit:
	mov ax, 4c00h
	int 21h

END start