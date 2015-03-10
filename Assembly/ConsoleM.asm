;------------------------------------------
; File   :  ConsoleMac.asm
; Author :  Etgar Shmueli
; Date   :  25/02/15
;------------------------------------------

macro Write Char
	push dx
	
	mov dl, Char
	call WriteProc
	
	pop dx
endm Write

macro WriteSeq Location
	push dx

	mov dx, Location
	call WriteSeqProc
	
	pop dx
endm WriteSeq

macro WriteLine Location
	push dx
	
	mov dx, [Location]
	call WriteLineProc
	
	pop dx
endm WriteLine

macro ReadLine Buffer
	push dx
	
	mov dx, [Buffer]
	call ReadLineProc
	
	pop dx
endm ReadLine

macro ReadKey
	call ReadKey
endm ReadKey

macro EnterVGAMode
	call EnterVGAModeProc
endm EnterVGAMode

macro SetBackgroundColor Color
	push bx
	
	mov bx, Color
	call SetBackgroundColorProc
	
	pop bx
endm SetBackgroundColor