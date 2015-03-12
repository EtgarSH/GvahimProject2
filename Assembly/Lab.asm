IDEAL
MODEL small
STACK 100h
DATASEG
	myMatrixDS db 100 dup(?)
	myMatrix equ offset myMatrixDS
CODESEG

include "ConsoleM.asm"
include "ArraysM.asm"
include "MatrixM.asm"

start:
	mov ax, @data
	mov ds, ax
	
	NewMatrix myMatrix, 3, 2; myMatrix = new int[3, 2]
	;GetNode myMatrix, 2, 1 ; int al = myMatrix[2, 1]
	;add al, 30h
	;Write al
exit:
	mov ax, 4c00h
	int 21h

include "ConsoleP.asm"
include "ArraysP.asm"
include "MatrixP.asm"

end start