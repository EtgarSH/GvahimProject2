IDEAL
MODEL small
STACK 100h
DATASEG
	filename db 'test.bmp', 0
	filehandle dw ?
	Header db 54 dup(0)
	Palette db 256*4 dup(0)
	ScrLine db 320 dup(0)
	ErrorMsg db 'Error', 13, 10, '$'
CODESEG

include "ConsoleM.asm"
include "ArraysM.asm"
include "MatrixM.asm"

start:
	mov ax, @data
	mov ds, ax
	
	mov ax, 13h
	int 10h
	; Process BMP file
	call OpenFile
	call ReadHeader
	call ReadPalette
	call CopyPal
	call CopyBitmap
	
	; Wait for key press
	mov ah,1
	int 21h
	
	; Back to text mode
	mov ah, 0
	mov al,2
	int 10h
	
exit:
	mov ax, 4c00h
	int 21h

include "ConsoleP.asm"
include "ArraysP.asm"
include "MatrixP.asm"

proc OpenFile

	mov ah, 3dh
	xor al, al
	mov dx, offset filename
	int 21h
	jc openerror
	mov [filehandle], ax

	ret
	
openerror:
	mov dx, offset ErrorMsg
	mov ah, 9h
	int 21h
	ret
endp OpenFile

proc ReadHeader
	mov ah, 3fh
	mov bx, [filehandle]
	mov cx, 54
	mov dx, offset Header
	int 21h
	ret
endp ReadHeader

proc ReadPalette
	mov ah, 3fh
	mov cx, 400h
	mov dx, offset Palette
	int 21h
	ret
endp ReadPalette

proc CopyPal
	mov si, offset Palette
	mov cx, 256
	mov dx, 3c8h
	mov al, 0
	
	out dx, al
	
	inc dx
	
PalLoop:
	mov al, [si+2]
	shr al, 2
	out dx, al
	
	mov al, [si+1]
	shr al, 2
	out dx, al
	
	mov al, [si]
	shr al, 2
	out dx, al
	
	add si, 4
	loop PalLoop
	
	ret
endp CopyPal

proc CopyBitMap
	mov ax, 0a000h
	mov es, ax
	mov cx, 200
PrintBMPLoop:
	push cx
	
	mov di, cx
	shl cx, 6
	shl di, 8
	add di, cx
	mov ah, 3fh
	mov cx, 320
	mov dx, offset ScrLine
	int 21h
	
	cld
	mov cx, 320
	mov si, offset ScrLine
	
	rep movsb
	pop cx
	loop PrintBMPLoop
	ret
endp CopyBitMap

end start