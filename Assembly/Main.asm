IDEAL
MODEL small
STACK 100h
DATASEG

	stringDS db 'joifjdog$'
	
	HelloDS db 'Hello World$'
	
	string equ offset stringDS
	HelloWorld equ offset HelloDS

CODESEG

include "ConsoleM.asm"

start:
	mov ax, @data
	mov ds, ax
	
	
	WriteSeq HelloWorld
	
exit:
	mov ax, 4c00h
	int 21h

END start