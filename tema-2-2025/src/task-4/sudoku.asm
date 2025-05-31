%include "../include/io.mac"

extern printf
global check_row
global check_column
global check_box

; you can declare any helper variables in .data or .bss
section .data
	freq dd 0, 0, 0, 0, 0, 0, 0, 0, 0

section .text


; int check_row(char* sudoku, int row);
check_row:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov     esi, [ebp + 8]  ; char* sudoku, pointer to 81-long char array
    mov     edx, [ebp + 12]  ; int row 
    ;; DO NOT MODIFY
   
    ;; Freestyle starts here
	xor ecx, ecx
	xor eax, eax
reset1:
	mov DWORD [freq + ecx * 4], eax
	mov eax, DWORD [freq + ecx * 4] ; resets the vector of frequncy
	inc ecx
	cmp ecx, 9
	je end_reset1
	jmp reset1
end_reset1:

	mov eax, 9
	mul edx ; positioning the eax on the first element
	mov edx, 1
	xor ecx, ecx

for_row:
	movzx ebx, BYTE [esi + eax] ; puts the frequncy in the array

	dec ebx
	add [freq + ebx * 4], edx 

	inc eax
	inc ecx
	cmp ecx, 9
	je end_for_row
	jmp for_row
end_for_row:

	mov eax, 1
	xor ecx, ecx
	
array_row_check:
	cmp eax, [freq + ecx * 4] ; check the freq array if it is good
	jne bad_row

	inc ecx
	cmp ecx, 9
	je end_array_row_check
	jmp array_row_check
bad_row:
	mov eax, 2
end_array_row_check:
    ;; MAKE SURE TO LEAVE YOUR RESULT IN EAX BY THE END OF THE FUNCTION
    ;; Remember: OK = 1, NOT_OKAY = 2
    ;; ex. if this row is okay, by this point eax should contain the value 1 

    ;; Freestyle ends here
end_check_row:
    ;; DO NOT MODIFY

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret
    
    ;; DO NOT MODIFY

; int check_column(char* sudoku, int column);
check_column:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov     esi, [ebp + 8]  ; char* sudoku, pointer to 81-long char array
    mov     edx, [ebp + 12]  ; int column 
    ;; DO NOT MODIFY
   
    ;; Freestyle starts here

	xor ecx, ecx
	xor eax, eax
reset2:
	mov DWORD [freq + ecx * 4], eax
	inc ecx
	cmp ecx, 9
	je end_reset2
	jmp reset2
end_reset2:

	mov eax, edx ; positioning the eax on the first element
	mov edx, 1
	xor ecx, ecx
for_column:
	movzx ebx, BYTE [esi + eax] ; puts the frequncy in the array

	dec ebx
	add [freq + ebx * 4], edx 

	add eax, 9
	inc ecx
	cmp ecx, 9
	je end_for_column
	jmp for_column
end_for_column:

	mov eax, 1
	xor ecx, ecx
	
array_column_check:
	cmp eax, [freq + ecx * 4] ; check the freq array if it is good
	jne bad_column

	inc ecx
	cmp ecx, 9
	je end_array_column_check
	jmp array_column_check
bad_column:
	mov eax, 2
end_array_column_check:


    ;; MAKE SURE TO LEAVE YOUR RESULT IN EAX BY THE END OF THE FUNCTION
    ;; Remember: OK = 1, NOT_OKAY = 2
    ;; ex. if this column is okay, by this point eax should contain the value 1 

    ;; Freestyle ends here
end_check_column:
    ;; DO NOT MODIFY

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret
    
    ;; DO NOT MODIFY


; int check_box(char* sudoku, int box);
check_box:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov     esi, [ebp + 8]  ; char* sudoku, pointer to 81-long char array
    mov     edx, [ebp + 12]  ; int box 
    ;; DO NOT MODIFY
   
    ;; Freestyle starts here

	xor ecx, ecx
	xor eax, eax
reset3:
	mov DWORD [freq + ecx * 4], eax
	inc ecx
	cmp ecx, 9
	je end_reset3
	jmp reset3
end_reset3:

	mov eax, edx
	mov ecx, 3
	xor edx, edx
	div ecx

	push edx
	mov ecx, 27
	mul ecx

	pop edx
	push eax
	mov eax, 3
	mul edx
	pop ecx
	add eax, ecx
	mov edx, 1
	xor ecx, ecx

for_box:
	movzx ebx, BYTE [esi + eax] ; puts the frequncy in the array
	inc eax
	dec ebx

	add [freq + ebx * 4], edx 

	movzx ebx, BYTE [esi + eax] ; puts the frequncy in the array
	inc eax
	dec ebx

	add [freq + ebx * 4], edx

	movzx ebx, BYTE [esi + eax] ; puts the frequncy in the array

	dec ebx
	add [freq + ebx * 4], edx

	add eax, 7
	inc ecx
	cmp ecx, 3
	je end_for_box
	jmp for_box
end_for_box:

	mov eax, 1
	xor ecx, ecx

array_box_check:
	cmp eax, [freq + ecx * 4] ; check the freq array if it is good
	jne bad_column

	inc ecx
	cmp ecx, 9
	je end_array_box_check
	jmp array_box_check
bad_box:
	mov eax, 2
end_array_box_check:
    ;; MAKE SURE TO LEAVE YOUR RESULT IN EAX BY THE END OF THE FUNCTION
    ;; Remember: OK = 1, NOT_OKAY = 2
    ;; ex. if this box is okay, by this point eax should contain the value 1 

    ;; Freestyle ends here
end_check_box:
    ;; DO NOT MODIFY

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret
    
    ;; DO NOT MODIFY
