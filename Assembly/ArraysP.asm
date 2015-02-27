;------------------------------------------
; File   :  Arrays.asm
; Author :  Etgar Shmueli
; Date   :  25/02/15
;------------------------------------------

proc IndexOutOfRangeException
	int 2
endp IndexOutOfRangeException

proc GetLengthProc ; bx - offset of array, returns length in cl
	mov cl, [byte ptr bx]
	ret
endp GetLengthProc

proc GetElementProc ; bx - offset of array. si - index. returns the element in al.
	push cx
	push si
	
	call GetLengthProc
	dec cl
	cmp si, cl
	jl NotOutOfRange
	call IndexOutOfRangeException
	
NotOutOfRange:
	inc si
	mov al, [byte ptr bx+si	

	pop si
	pop cx
	ret
endp GetElementProc

proc AddElementProc ; bx - offset of array; dl - element
	push ax
	push bx
	push cx
	
	call GetLengthProc
	
	inc [byte ptr bx]
	xor ch, ch
	add bx, cx
	
	inc bx
	mov [byte ptr bx], dl
	
	pop cx
	pop bx
	pop ax
	ret
endp AddElementProc

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

proc Average ; bx - offset of the array, returns ax - average
	call Sum
	cmp al, 0
	jz EmptyArrayAVG
	call Sum
	xor ah, ah
	call GetLengthProc
	
	div cl
	jmp EndAverage

EmptyArrayAVG:
	xor ax, ax
EndAverage:
	ret
endp Average

proc PrintArray; bx is the offset of the array
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
	ret
endp PrintArray