IDEAL
MODEL small
STACK 100h
DATASEG
	myMatrixDS db 100 dup(?)
	myMatrix equ offset myMatrixDS
	
	myArrayDS db 11 dup(?)
	myArray equ offset myArrayDS
	arrayLengh equ 21
	
	part_2_inputDS db 5 dup(4)
	part_2_input db offset part_2_inputDS
	
	error_messageDS db 'Illegal input$'
	error_message db offset error_message
	
	sumArrayDS db 6 dup (?)
	sumArray equ offset sumArrayDS
CODESEG

include "ConsoleM.asm"
include "ArraysM.asm"
include "MatrixM.asm"

start:
	mov ax, @data
	mov ds, ax
	
	NewMatrix myMatrix, 3, 2
	;GetNode myMatrix, 2, 1
	;add al, 30h
	;Write al
	PrintMatrix myMatrix
exit:
	mov ax, 4c00h
	int 21h

include "ConsoleP.asm"
include "ArraysP.asm"
include "MatrixP.asm"

end start