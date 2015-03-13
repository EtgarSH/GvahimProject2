IDEAL
MODEL small
STACK 100h
DATASEG
	MatrixDS db 100 dup(?)
	Matrix equ offset MatrixDS
	Matrix_rows equ 6
	Matrix_colums equ 4
	
	sumArrayDS db 20 dup (?)
	sumArrayOffset equ offset sumArrayDS
	
	part_2_inputDS db 6 dup(4)
	part_2_input dw offset part_2_inputDS
	
	error_messageDS db 0ah,'Illegal input',0ah,'$'
	error_message dw offset error_messageDS
	
	enter_valuesDS db 'Enter values$'
	enter_values dw offset enter_valuesDS
	
	Not_foundDS db 0ah,'Value doesnt exist',0ah,'$'
	Not_found dw offset Not_foundDS
	
	part2MessageDS db 0ah,'Enter input',0ah,'$'
	part2Message dw offset part2MessageDS
		

CODESEG

include "ConsoleM.asm"
include "ArraysM.asm"
include "MatrixM.asm"
include "sound.asm"

macro to_dec_from_hex value ; Result in al. ;The program gets a value and make it look like dec, that i'll be able to print an hex value in dec.
;Example: al=1Fh ---> al=31h
	push dx
	mov al, value
	mov dl,0ah
	xor ah,ah
	div dl
	shl al,4
	add al,ah
	pop dx
endm

macro print_space
	Write ' '
endm

macro check_value_range minVal, maxVal, Val ;Comparing to C#: if ((Val<maxVal)&&(Val>minVal)) {dl = 1} else {dl=0}
	local end_check_value_range, false
	push ax
	mov al,Val
	cmp al,minVal
	jb false
	cmp al,maxVal
	ja false
	mov dl,1
	jmp end_check_value_range
false:
	xor dl,dl
end_check_value_range:
	pop ax
endm

macro down_line
	Write 0ah
endm

start:
	mov ax, @data
	mov ds, ax
	;part1
	NewMatrix Matrix, 6, 4
	;NewArray sumArrayOffset 6
Part_1:
	WriteLine enter_values
	down_line
	xor ax,ax
	xor dx,dx
	mov cx,Matrix_rows
	; The next loop is an boolean loop (like in C#). In this loop, the program gets from the user an input (char).
	;The program check if the input is legal. If the input is illegal the program will print an error message.
	;If the input is legal the program will change the ASCII value to hex number, and will put it in the matrix.
get_Matrix_rows: ;dh=rows; dl=colums
	push cx
	mov cx, Matrix_colums
	call get_Matrix_columsProc ;The loop couldn't work because there was to much space between the loop and the lable.
	pop cx
	down_line
	inc dh
	loop get_Matrix_rows
	
	GetArrayOfSums Matrix sumArrayOffset
	PrintArray sumArrayOffset
	;Part 2
part_2:
	WriteLine part2Message
	down_line
	ReadLine part_2_input 
	mov al,[part_2_inputDS +1] ;Mov al how many chars the user actually typed. Then, the progam checl what is the value and respond in accordance.
	cmp al,3
	je print_matrix_index
	cmp al,2
	je print_num_Of_shows
	mov al,[part_2_inputDS +2]
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
	cmp al, 'm'
	jne notMusicYea
	call PlayMusic

notMusicYea:
	cmp al,'#'
	je end_part_two_between
	jmp check_value
	
error_tab:
	down_line
	WriteLine error_message
	jmp part_2
Not_found_tab:
	WriteLine Not_found
	jmp part_2
print_matrix:
	down_line
	call print_matrixProc
	jmp part_2
print_matrix_index:
	call print_matrix_index_Proc
	jmp part_2
end_part_two_between:
	jmp end_part_two

print_num_Of_shows:
	mov al,[part_2_inputDS +3]
	call Check_if_value_is_hex
	cmp dh,0
	je error_tab_between
	sub al,30h
	call get_num_of_showsProc
	mov al,dl
	call print_unknow_leght_number
	jmp part_2
print_max_value:
	call get_max_valueProc
	mov al,ah
	call print_hexProc
	jmp part_2
print_min_value:
	call get_min_valueProc
	mov al,ah
	call print_hexProc
	jmp part_2
	jmp part_2
error_tab_between: ;je can't get to the lable.
	jmp error_tab
Not_found_tab_between: ;je can't get to the lable.
	jmp Not_found_tab
check_value:
	call Check_if_value_is_hex
	cmp dh,0
	je error_tab_between
	call ascii_to_hex
	call get_place
back: ;There was an error and that was the only way to solve it.
	cmp bl,15h
	je Not_found_tab_between
	jmp part_2
end_part_two:


exit:
	mov ax, 4c00h
	int 21h
	
include "ConsoleP.asm"
include "ArraysP.asm"
include "MatrixP.asm"

proc PlayMusic
	call audio_open
	call acsess
	call speak1
	call speak2
	call speak3
	call speak4
	call speak5
	call speak6
	call speak7
	call speak8
	call speak9
	call audio_closer
	
	ret
endp PlayMusic

proc get_Matrix_columsProc
get_Matrix_colums:
get_Matrix_columsstart:
	ReadKey_show_char 
	push dx
	xor dx,dx ;Checking if the input is legal.
	call Check_if_value_is_hex
	cmp dh,0
	je error_tab_part1
	call ascii_to_hex ;Change the input to ascii
	pop dx
	SetNode Matrix dh dl al
	jmp end_get_Matrix_columsLoop
error_tab_part1:
	pop dx
	WriteLine error_message
	jmp get_Matrix_columsstart
end_get_Matrix_columsLoop:
	inc dl
	print_space
	loop get_Matrix_colums
	xor dl,dl
	ret
endp get_Matrix_columsProc
proc print_matrix_index_Proc
	mov al,[part_2_inputDS+3]
	cmp al,' '
	jne error_pring_message
	mov al,[part_2_inputDS +4]
	check_value_range '0' '9' al
	cmp dl,0h
	je error_pring_message
	mov al,[part_2_inputDS +2]
	check_value_range '0' '9' al
	cmp dl,0h
	je error_pring_message
	mov ah,[part_2_inputDS+4]
	sub al,31h
	sub ah,31h
	cmp al,6
	jae error_pring_message
	cmp ah,4
	jae error_pring_message
	GetNode Matrix al ah
	call print_hexProc
	jmp print_matrix_indexProc_end
error_pring_message:
	WriteLine error_message
print_matrix_indexProc_end:
	ret
endp print_matrix_index_Proc
proc print_matrixProc ;dh =row dl=colum
	xor dx,dx
	mov cx, Matrix_rows
print_matrixRows:
	push cx
	mov cx,Matrix_colums
	xor dh,dh
print_matrixColums:
	GetNode Matrix dl dh
	call print_hexProc
	print_space
	inc dh
	loop print_matrixColums
	down_line
	pop cx
	inc dl
	loop print_matrixRows
	ret
endp print_matrixProc
proc get_num_of_showsProc ;Returns the num of shows in dl num in al;
	mov ah,al
	mov cx,Matrix_rows
	xor bx,bx
	xor dx,dx
get_num_of_shows_rows: ;dh=rows; dl=colums; ah=num
	push cx
	mov cx, Matrix_colums
get_num_of_shows_colums:
	push bx
	GetNode Matrix dh dl
	pop bx
	cmp ah,al
	je add_one
	jmp end_get_num_of_shows_colums
add_one:
	inc bl
end_get_num_of_shows_colums:
	inc dl
	loop get_num_of_shows_colums
	xor dl,dl
	pop cx
	inc dh
	loop get_num_of_shows_rows
	mov dl,bl
	ret
endp get_num_of_showsProc

proc get_max_valueProc ;Returns the max value of shows in dl
	push cx
	xor dx,dx
	mov cx,Matrix_rows
	GetNode Matrix 0 0
	mov ah,al
get_Matrix_max_rows: ;dh=rows; dl=colums; ah max value
	push cx
	mov cx, Matrix_colums
get_Matrix_max_colums:
	GetNode Matrix dh dl
	cmp ah,al
	jnb end_get_Matrix_max_colums
	mov ah,al
end_get_Matrix_max_colums:
	inc dl
	loop get_Matrix_max_colums
	xor dl,dl
	pop cx
	inc dh
	loop get_Matrix_max_rows
	mov dl,ah
	pop cx
	ret
endp get_max_valueProc

proc get_min_valueProc ;Returns the min value of shows in dl
	push cx
	xor dx,dx
	mov cx,Matrix_rows
	GetNode Matrix 0 0
	mov ah,al
get_Matrix_min_rows: ;dh=rows; dl=colums; ah min value
	push cx
	mov cx, Matrix_colums
get_Matrix_min_colums:
	GetNode Matrix dh dl
	cmp ah,al
	jna end_get_Matrix_min_colums
	mov ah,al
end_get_Matrix_min_colums:
	inc dl
	loop get_Matrix_min_colums
	xor dl,dl
	pop cx
	inc dh
	loop get_Matrix_min_rows
	mov dl,ah
	pop cx
	ret
endp get_min_valueProc

proc print_unknow_leght_number ;Num is in al 
;This proc get an value (in al) in hex. The program is printing the value in dec.
	to_dec_from_hex al
	xor ah,ah
	ror ax,4
	shr ah,4
	add ah,30h
	add al,30h
	Write al
	Write ah
	ret
endp print_unknow_leght_number

proc ascii_to_hex ;Value in al and result too
	xor dx,dx
	check_value_range '0', '9',al 
	cmp dl,1
	je num_to_hex
	check_value_range 'A', 'F',al 
	cmp dl,1
	je char_to_hex
	sub al,57h
	jmp end_ascii_to_hexProc
num_to_hex:
	sub al,30h
	jmp end_ascii_to_hexProc
char_to_hex:
	sub al,37h
end_ascii_to_hexProc:
	ret
endp ascii_to_hex

proc print_hexProc ;the value in al
;This proc gets an value and printing it as hex.
	cmp al,0ah
	jae print_char
	add al,30h
	Write al
	jmp end_print_hexProc
print_char:
	add al,37h
	Write al
end_print_hexProc:
	ret
endp print_hexProc

proc get_place ;al is the value
;This proc gets a value and find the first index in the matrix the equal to the value.
;If the value haven't been found the program will print an error message.
	xor dx,dx
	mov ah,al
	mov cx,Matrix_rows
get_place_rows:
	push cx
	mov cx,Matrix_colums
get_place_colums:
	GetNode Matrix dh dl
	cmp ah,al
	je found
	inc dl
	loop get_place_colums
	xor dl,dl
	pop cx
	inc dh
	loop get_place_rows
	mov bl,15h
	jmp end_get_place
	found:
	add dx,3030h
	Write dh
	print_space
	Write dl
	end_get_place:
	call back
	ret
endp get_place
Proc Check_if_value_is_hex
	xor dx,dx
	check_value_range '0', '9',al 
	add dh,dl
	check_value_range 'A', 'F',al 
	add dh,dl
	check_value_range 'a', 'f',al 
	add dh,dl
	ret
endp Check_if_value_is_hex
END start