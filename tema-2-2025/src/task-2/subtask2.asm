%include "../include/io.mac"

; declare your structs here
struc date
	.day: resb 1
	.month: resb 1
	.year: resb 2
endstruc

struc event
	.name: resb 31
	.valid: resb 1
	.date: resb date_size 
endstruc

section .bss
	aux resb event_size

section .text
    global sort_events
    extern printf

sort_events:
    ;; DO NOT MODIFY
    enter 0, 0
    pusha

    mov ebx, [ebp + 8]      ; events
    mov ecx, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here

	xor esi, esi ; counter of the first element of the sort
	xor eax, eax
first_for:
	mov edi, esi
	add edi, event_size ; counter for the second elemnt of the sort

	push eax
	inc eax

second_for:

	cmp eax, ecx
	je end_second_for

	push eax

verify_validity:

	lea eax, [ebx + esi] ; valid of the first element
	mov dh,  BYTE [eax + event.valid]

	lea eax, [ebx + edi] ; valid of the secondelement
	mov dl, byte [eax + event.valid]

	cmp dh, dl ; check the validity for the swap
	je verify_year
	jl swap
	jmp no_swap

verify_year:

	lea eax, [ebx + esi + event.date] ; year of the first element
	mov dx,  WORD [eax + date.year]

	lea eax, [ebx + edi + event.date] ; year of the second element
	mov ax, WORD [eax + date.year]

	cmp dx, ax
	je verify_month
	jg swap
	jmp no_swap

verify_month:

	lea eax, [ebx + esi + event.date] ; month of the first element
	mov dh,  BYTE [eax + date.month]

	lea eax, [ebx + edi + event.date] ; month of the second element
	mov dl, BYTE [eax + date.month]

	cmp dh, dl ; check the validity for the swap
	je verify_day
	jg swap
	jmp no_swap

verify_day:

	lea eax, [ebx + esi + event.date] ; day of the first element
	mov dh,  BYTE [eax + date.day]

	lea eax, [ebx + edi + event.date] ; day of the second element
	mov dl, BYTE [eax + date.day]

	cmp dh, dl ; check the validity for the swap
	je verify_name
	jg swap
	jmp no_swap

verify_name:

	push ecx
	xor ecx, ecx
check_name:

	lea eax, [ebx + esi + event.name] ; name of the first element
	mov dh,  BYTE [eax + ecx]

	lea eax, [ebx + edi + event.name] ; name of the secondelement
	mov dl, BYTE [eax + ecx]

	cmp dh, dl
	jne end_check_name

	inc ecx
	cmp ecx, 31
	je end_check_name
	jmp check_name
end_check_name:

	pop ecx
	jng no_swap

swap:

	lea eax, [ebx + esi] 
	lea edx, [ebx + edi]

	push ebx ; saving the register
	push ecx

	xor ecx, ecx
copy_to_aux:

	mov bl, BYTE [eax + ecx] ; copy bites to aux
	mov BYTE [aux + ecx], bl

	inc ecx
	cmp ecx, event_size
	je end_copy_to_aux
	jmp copy_to_aux
end_copy_to_aux:

	xor ecx, ecx
copy_to_source:

	mov bl, BYTE [edx + ecx] ; copy bites to source
	mov BYTE [eax + ecx], bl

	inc ecx
	cmp ecx, event_size
	je end_copy_to_source
	jmp copy_to_source
end_copy_to_source:

	xor ecx, ecx
copy_to_dest:

	mov bl, BYTE [aux + ecx]
	mov BYTE [edx + ecx], bl ; copy bites to dest

	inc ecx
	cmp ecx, event_size
	je end_copy_to_dest
	jmp copy_to_dest
end_copy_to_dest:

	pop ecx ; retriving the registers
	pop ebx

no_swap:

	pop eax
	add edi, event_size
	inc eax
	cmp eax, ecx
	je end_second_for
	jmp second_for

end_second_for:

	pop eax
	add esi, event_size
	inc eax
	cmp eax, ecx
	je end_first_for
	jmp first_for
end_first_for:

    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY