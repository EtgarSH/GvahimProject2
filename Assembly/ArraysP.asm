;------------------------------------------
; File   :  Arrays.asm
; Author :  Etgar Shmueli
; Date   :  25/02/15
;------------------------------------------
; Test
DataSeg
outOfRangeMsg db 'Index out of range exception!$'
ofre equ offset outOfRangeMsg

CodeSeg
proc IndexOutOfRangeException
	WriteLine ofre
	mov ax, 4c00h
	int 21h
endp IndexOutOfRangeException

proc CheckOutOfRange ; bx - array. dh - index.
	push cx
	
	call GetLengthProc
	cmp dh, cl
	jl NotOutOfRange
	call IndexOutOfRangeException
	
NotOutOfRange:
	pop cx
	ret
endp CheckOutOfRange

proc NewArrayProc ; bx - offset. cl - length.
	mov [byte ptr bx], cl
	call ClearArrayProc
	ret
endp NewArrayProc

proc ClearArrayProc ; bx - offset
	push cx
	push bx
	
	call GetLengthProc
	xor ch, ch
	
	inc bx
ClearArrayLoop:
	mov [byte ptr bx], 0
	inc bx
	loop ClearArrayLoop
	
	pop bx
	pop cx
	ret
endp ClearArrayProc

proc GetLengthProc ; bx - offset of array, returns length in cl
	mov cl, [byte ptr bx]
	ret
endp GetLengthProc

proc GetElementProc ; bx - offset of array. cl - index. returns the element in al.
	push cx
	push bx
	
	call CheckOutOfRange

	xor ch, ch
	add bx, cx
	inc bx
	mov al, [byte ptr bx]

	pop bx
	pop cx
	ret
endp GetElementProc

proc SetElementProc ; bx - offset. cl - index. dl - element.
	push cx
	push bx
	
	call CheckOutOfRange

	xor ch, ch
	add bx, cx
	inc bx
	mov [byte ptr bx], dl

	pop bx
	pop cx
	ret
endp SetELementProc

proc BubbleSort ; bx - offset of array
	push ax
	push bx
	push dx
	push cx
	
	xor ch, ch
	mov cl, [byte ptr bx]
	cmp cl, 2
	jl EndSort
	dec cl
	
	inc bx
	
	mov dx, bx
	add dx, cx
outerLoop:
	
	push bx
firstLoop:
	mov ah, [bx]
	mov al, [bx+1]
	
	cmp ah, al
	jna continue
	mov [bx], al ; Swap...
	mov [bx+1], ah
	
continue:
	inc bx
	cmp bx, dx
	jnz firstLoop
	pop bx
	loop outerLoop
EndSort:
	pop cx
	pop dx
	pop bx
	pop ax
	ret
endp BubbleSort

proc sumProc ; bx is the offset of the array, returns al is the sum
	push cx
	push si
	push bx
	
	xor al, al
	
	xor ch, ch
	call GetLengthProc
	
	cmp cl, 0
	jz EndSum
	
	inc bx
SumLoop:
	add al, [byte ptr bx]
	inc bx
	loop SumLoop

EndSum:
	pop bx
	pop si
	pop cx
	
	ret
endp sumProc

proc AverageProc ; bx - offset of the array, returns ax - average
	call sumProc
	cmp al, 0
	jz EmptyArrayAVG
	call sumProc
	xor ah, ah
	call GetLengthProc
	
	div cl
	jmp EndAverage

EmptyArrayAVG:
	xor ax, ax
EndAverage:
	ret
endp AverageProc

proc PrintArrayProc ; bx is the offset of the array
	push cx
	push dx
	push bx
	
	xor ch, ch
	call GetLengthProc
	cmp cl, 0
	jz EndPrintArray
	inc bx
PrintArrayLoop:
	mov dl, [byte ptr bx]
	add dl, 30h
	call WriteProc
	
	mov dl, ' '
	call WriteProc
	
	inc bx
	loop PrintArrayLoop
EndPrintArray:
	pop bx
	pop dx
	pop cx
	
	Write 10
	ret
endp PrintArrayProc