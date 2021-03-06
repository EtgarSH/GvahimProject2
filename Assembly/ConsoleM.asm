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
	call ReadKeyProc
endm ReadKey

macro ReadKey_show_char
	call ReadKey_show_charProc
endm ReadKey_show_char

macro EnterVGAMode
	call EnterVGAModeProc
endm EnterVGAMode

macro SetBackgroundColor Color
	push bx
	xor bh,bh
	mov bl, Color
	call SetBackgroundColorProc
	
	pop bx
endm SetBackgroundColor