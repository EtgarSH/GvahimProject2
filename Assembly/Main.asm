IDEAL
MODEL small
STACK 100h
DATASEGs

CODESEG

include "ConsoleM.asm"
include "ArraysM.asm"

start:
	mov ax, @data
	mov ds, ax
	
	
	WriteSeq HelloWorld
	
exit:
	mov ax, 4c00h
	int 21h

END start