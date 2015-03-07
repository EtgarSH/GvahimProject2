IDEAL
MODEL small
STACK 100h
DATASEG
	myMatrixDS db 100 dup(?)
	myMatrix equ offset myMatrixDS
	
	myArrayDS db 11 dup(?)
	myArray equ offset myArrayDS
	arrayLegh equ 21
	
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

macro print_space
	push ax
	push dx
	mov ah,2h
	mov dl,20h
	int 21h
	pop dx
	pop ax
endm

macro check_vale_range minVal, maxVal, Val
	local end_check_vale_range, false
	push ax
	mov al,Val
	cmp al,minVal
	jb false
	cmp al,maxVal
	ja false
	mov dl,1
	jmp end_check_vale_range
false:
	xor dl,dl
end_check_vale_range:
	pop ax
endm

macro down_line
	push ax
	push dx
	mov ah,2h
	mov dl,0ah
	int 21h
	pop dx
	pop ax
endm

start:
	mov ax, @data
	mov ds, ax
	
	NewMatrix myMatrix, 4, 3
	GetNode myMatrix, 0, 0
	add al, 30h
	Write al
	
	;Part 2
part_2:
	ReadLine part_2_input
	mov al,[part_2_inputDS +1]
	cmp al,3
	je print_matrix_index
	cmp al,2
	je print_num_Of_shows
	mov al,[part_2_inputDS +3]
	cmp al,'?'
	je print_matrix
	cmp al,'H'
	je print_max_value
	cmp al,'h'
	je print_max_value
	cmp al,'L'
	je print_min_value
	cmp al,'l'
	je print_min_value
	cmp al,'#'
	je end_part_two
	jmp check_vale
	
error_tab:
	WriteLine error_message
	jmp part_2
	
print_matrix_index:
	call print_matrix_indexProc
	jmp part_2
print_num_Of_shows:
	call get_num_of_showsProc
	jmp part_2
print_max_value:
	call get_max_valueProc
	print_space
	Writ dl
	down_line
	jmp part_2
	print_min_value:
	call get_min_valueProc
	print_space
	Writ dl
	down_line
	jmp part_2
check_vale:
	xor dx,dx
	check_vale_range '0', '9',al 
	add dh,dl
	check_vale_range 'A', 'F',al 
	add dh,dl
	check_vale_range 'a', 'f',al 
	add dh,dl
	cmp dh,0
	je error_tab
	
	
		
	
end_part_two:
exit:
	mov ax, 4c00h
	int 21h
	
include "ConsoleP.asm"
include "ArraysP.asm"
include "MatrixP.asm"

proc print_matrix_indexProc
	
	ret
endp print_matrix_indexProc

proc get_num_of_showsProc ;Returns the num of shows in dl
	
	ret
endp get_num_of_showsProc

proc get_max_valueProc ;Returns the max value of shows in dl
	push cx
	push bx
	xor bx,bx
	xor dl,dl
	mov cx,[arrayLegh]
find_max_loop:
	cmp dl,[myArray +bx]
	jb new_max
	jmp end_max_loop
new_max:
	mov dl, [myArray+bx]
	end_max_loop:
	inc bx
	loop find_max_loop
	pop bx
	pop cx
	ret
endp get_max_valueProc

proc get_min_valueProc ;Returns the max value of shows in dl
	push cx
	push bx
	xor bx,bx
	xor dl,dl
	mov cx,[arrayLegh]
find_min_loop:
	cmp dl,[myArray +bx]
	jb new_min
	jmp end_min_loop
new_min:
	mov dl, [myArray+bx]
end_min_loop:
	inc bx
	loop find_min_loop
	
	pop bx
	pop cx
	ret
endp get_min_valueProc
END start
