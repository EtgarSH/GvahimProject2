CODESEG
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
	 
	;speakers ****************************************
	;every proc end in high-light noise to create diffrence betwin the sound in the reading
	;in all of the loops the is only one xor, the reason is that when overfloat as the plans the cx value returns to the zero value and by that xor the loop.
	;the loop is being xored in every 'speak' due fear of it to be changed in the working of the over procs.
	;all the sounds are being played in loop of 2^16-1, the longness of the playing is for the user to notice.
	;the purpose the playing \ loop labals is in all of the procs is for the jump of the loop commend.
	;the system design, proc including playing and calls in the labals makes the returning more understandable for code readers and to control the sounds order.
	;sXip = sound NUMBER in the proc 
proc speak1 
	xor cx,cx ;loop counter
playing329: ;the only sound in the proc
	call fre380 ;calling for the sound proc
	loop playing329 
	call light_noises
	ret
endp speak1
	
proc speak2
	xor cx,cx ;making it go for 2^15 - 1 ***
playing414: ;s1ip
	call fre414
	loop playing414
playing380: ;s2ip;the loop ended by cx becoming zero, and becous of that i can count on this to start decrising from zero or less for the longer way
	call fre380
	loop playing380 
	call light_noises	
	ret
endp speak2
	
proc speak3 ;in that speak there is one sound more than needed, it's becous one of them can't be heared clearly becous of his highness
	xor cx,cx ;loop counter
playing307_8: ;s1ip
	call fre307_8
	loop playing307_8
playing295: ;s2ip
	call fre295
	loop playing295
playing232: ;s3ip
	call fre232
	loop playing232
playing329_2: ;s4ip
	call fre329
	loop playing329_2
	call light_noises
	ret
endp speak3
	
proc speak4
	xor cx,cx ;loop counter
playing390: ;s1ip
	call fre390
	loop playing390 
playing573: ;s2ip
	call fre573
	loop playing573
playing412: ;s3ip
	call fre412
	loop playing412
playing283: ;s4ip
	call fre283
	loop playing283
	call light_noises 
	ret
endp speak4
	
proc speak5
	xor cx,cx ;loop counter
playing307_8_2: ;s1ip
	call fre307_8
	loop playing307_8_2
playing399: ;s2ip
	call fre399
	loop playing399
playing345: ;s3ip
	call fre345
playing414_2:  ;s4ip
	call fre414
	loop playing414_2
playing390_2: ;s5ip
	call fre390
	loop playing390_2
	call light_noises
	ret 
endp speak5
	
proc speak6
	xor cx,cx ;loop counter
playing232_2: ;s1ip
	call fre232
	loop playing232_2 
playing307_8_3: ;s2ip
	call fre307_8
	loop playing307_8_3
playing573_2: ;s3ip
	call fre573
	loop playing573_2
playing283_2: ;s4ip
	call fre283
	loop playing283_2
playing295_2: ;s5ip
	call fre295
	loop playing295_2
playing232_3: ;s6ip
	call fre232
	loop playing232_3
	call light_noises
	ret
endp speak6
	
proc speak7
	xor cx,cx ;loop counter
playing370: ;s1ip
	call fre370
	loop playing370 
playing352: ;s2ip
	call fre352
	loop playing352
playing318: ;s3ip
	call fre318
	loop playing318
playing380_2: ;s4ip
	call fre380
	loop playing380_2
playing412_2: ;s5ip
	call fre412
	loop playing412_2
playing307_2: ;26ip
	call fre307_8
	loop playing307_2
playing399_2: ;s7ip
	call fre399
	loop playing399_2
	call light_noises
	ret
endp speak7
	
proc speak8
	xor cx, cx
playing399_3_0: ;s1ip
	call fre399
	loop playing399_3_0
playing345_2: ;s2ip
	call fre345 
	loop playing399_2
playing370_2: ;s3ip
	call fre370
	loop playing370_2
playing352_2: ;s4ip
	call fre352
	loop playing352_2
playing318_2: ;s5ip
	call fre318
	loop playing318_2
playing329_3: ;s6ip
	call fre329
	loop playing329_3
playing414_3: ;s7ip
	call fre414
	loop playing414_3
playing307_4:
	call fre307_8 ;because we have the sound in the fre 307 twice we use the labal playing307 for both sounds 
	loop playing307_4
	call light_noises
	ret
endp speak8
	
proc speak9
	xor cx, cx
playing380_3: ;s1ip
	call fre380
	loop playing380_3
playing307_3: ;s2ip
	call fre307_9
	loop playing307_3
playing295_3: ;s3ip
	call fre295
	loop playing295_3 
playing232_3_0: ;s4ip
	call fre232 
	loop playing232_3_0
playing390_3: ;s5ip
	call fre390
	loop playing390_3
playing573_3: ;s6ip
	call fre573
	loop playing573_3
playing412_3: ;s7ip
	call fre412
	loop playing412_3
playing283_3: ;s8ip
	call fre283
	loop playing283_3
playing399_3: ;s9ip
	call fre399
	loop playing399_3
	call light_noises
	ret
endp speak9
	
proc audio_open ;open the audio
	in al, 61h  ;open the audio port
	or al, 00000011b ;"turn on" the last to bits in the port and by that turn on the audio 
	out 61h, al ;exit the audio port 
	ret
endp audio_open
	
proc acsess ;getting acsess to the change in the audio
	mov al, 0b6h 
	out 43h, al 
	ret
endp acsess
	
proc Random_clock
	mov ah, 2ch
	int 21h ;getting random number from the milisecound of the clock
	push dx ;pushing for returning number in the using proc
	ret 
endp Random_clock
	
	;sounds !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
proc light_noises
	mov cx, 330h
noise:
	mov al, 97h ;frequancy about 414.2986111111 Herz
	out 42h, al ;first less important devisor input <
	mov al, 03h ;first less important devisor input />
	out 42h, al ;secound more mportant devisor input />
	loop noise
	ret
endp light_noises
	
proc fre329 ;frequancy about 329.8811169477468 Herz 
   	mov al, 21h ;less imp.output <
	out 42h, al ;less imp.output />
	mov al, 0eh ;more imp.output <
	out 42h, al ;more imp.output />
	ret
endp fre329
	
proc fre414  
	mov al, 98h ;frequancy about 414.2986111111 Herz
	out 42h, al ;less imp.output <
	mov al, 0bh ;more imp.output <
	out 42h, al ;more imp.output />
	ret
endp fre414
	
proc fre380 ;frequancy about 380.2538189929892 Herz 
	mov al, 42h ;less imp.output <
	out 42h, al ;less imp.output />
	mov al, 0ch ;more imp.output <
	out 42h, al ;more imp.output />
	ret
endp fre380
	
proc fre307_8 ;frequancy about 307.9969024264326 Herz
	mov al, 22h ;less imp.output <
	out 42h, al ;less imp.output />
	mov al, 0fh ;more imp.output <
	out 42h, al ;more imp.output />
	ret
endp fre307_8
	
proc fre295 ;frequancy about 295.1954477981197 Herz
	mov al, 0cah ;less imp.output <
	out 42h, al ;less imp.output />
	mov al, 0fh ;more imp.output <
	out 42h, al ;more imp.output />
	ret
endp fre295
	
proc fre232 ;frequancy about 232.4898674980514 Herz
	mov al, 0cah ;less imp.output <
	out 42h, al ;less imp.output />
	mov al, 0fh ;more imp.output <
	out 42h, al ;more imp.output />
	ret
endp fre232
	
proc fre390 ;frequancy about 390.4384816753927 Herz
	mov al, 0f0h ;less imp.output <
	out 42h, al ;less imp.output />
	mov al, 0bh ;more imp.output <
	out 42h, al ;more imp.output />
	ret
endp fre390
	
proc fre573 ;frequancy about 573.6442307692308 Herz ;-
	mov al, 020h ;less imp.output <
	out 42h, al ;less imp.output />
	mov al, 08h ;more imp.output <
	out 42h, al ;more imp.output />
	ret
endp fre573
	
proc fre412 ;frequancy about 412.8650519031142 Herz 
	mov al, 04ah ;less imp.output <
	out 42h, al ;less imp.output />
	mov al, 0bh ;more imp.output <
	out 42h, al ;more imp.output />
	ret 
endp fre412
	
proc fre283 ;frequancy about 283.6177798906584 Herz
	mov al, 06fh ;less imp.output <
	out 42h, al ;less imp.output />
	mov al, 10h ;more imp.output <
	out 42h, al ;more imp.output />
	ret 
endp fre283
	
proc fre307_9 ;frequancy about 307.8379772961816 Herz
	mov al, 024h ;less imp.output <
	out 42h, al ;less imp.output />
	mov al, 0fh ;more imp.output <
	out 42h, al ;more imp.output />
	ret 
endp fre307_9
	
proc fre399 ;frequancy about 399.7252931323283 Herz
	mov al, 0a9h ;less imp.output <
	out 42h, al ;less imp.output />
	mov al, 0bh ;more imp.output <
	out 42h, al ;more imp.output />
	ret
endp fre399
	
proc fre345 ;frequancy about 345.7490582439873 Herz
	mov al, 07bh ;less imp.output <
	out 42h, al ;less imp.output />
	mov al, 0dh ;more imp.output <
	out 42h, al ;more imp.output />
	ret
endp fre345
	
proc fre370 ;frequancy about 370.3227808814401H Herz
	mov al, 096h
	out 42h, al
	mov al, 0ch	
	out 42h, al
	ret
endp fre370
	
proc fre352 ;frequancy about 352.2822556834957H Herz
	mov al, 52h
	out 42h, al
	mov al, 03h
	out 42h, al
	ret
endp fre352
	
proc fre318 ;frequancy about 352.2822556834957H Herz
	mov al, 18h
	out 42h, al
	mov al, 03h
	out 42h, al
	ret
endp fre318
	;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	
proc audio_closer ;turning off the audio
	in al,61h ;enter 61h port
	and al, 11111100b ;turn off the two last bites of the port and by that stop the audio activity
	out 61h, al  ;exiting the audio
	ret 
endp audio_closer
;1193180 = constant
;2615dDevidor -> 456.282982791587H //used in light_noises proc ;used as pause
;3617dDevidor -> 329.8811169477468H //used in speak1, speak3 and speak8 procs ;sound 1
;2882dDevidor -> 414.2986111111111H //used in speak2, speak5 and speak8 procs ;sound 2
;3138dDevidor -> 380.2538189929892H //used in speak2, speak7 and speak9 procs ;sound 3
;3874dDevidor -> 307.9969024264326H //used in speak3, speak6 and speak9 procs ;sound 4
;4042dDevidor -> 295.1954477981197H //used in speak3, speak6 and speak9 procs ;sound 5
;5132dDevidor -> 232.4898674980514H //used in speak3, speak6 and speak9 procs ;sound 6
;3056dDevidor -> 390.4384816753927H //used in speak4, speak5 and speak9 procs ;sound 7
;2080dDevidor -> 573.6442307692308H //used in speak4, speak6 and speak9 procs ;sound 8
;2890dDevidor -> 412.8650519031142H //used in speak4, speak6 and speak9 procs ;sound 9
;4207dDevidor -> 283.6177798906584H //used in speak4, speak6 and speak9 procs ;sound 10
;2985dDevidor -> 399.7252931323283H //used in speak5, speak8 and speak9 procs ;sound 11
;3876dDevidor -> 307.8379772961816H //used in speak5 and speak7 procs ;sound 12
;3451dDevidor -> 345.7490582439873H //used in speak5 and speak8 procs ;sound 13
;3222dDevidor -> 370.3227808814401H //used in speak6 and speak8 procs ;sound 14
;3387dDevidor -> 352.2822556834957H //used in speak6 and speak8 procs ;sound 15
;3751dDevidor -> 318.0965075973873H //used in speak6 and speak8 procs ;sound 16