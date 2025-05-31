%include "../include/io.mac"

extern printf
global remove_numbers

section .data
	fmt db "%d", 10, 0

section .text

; function signature: 
; void remove_numbers(int *a, int n, int *target, int *ptr_len);

remove_numbers:
	;; DO NOT MODIFY
	push    ebp
	mov     ebp, esp
	pusha

	mov     esi, [ebp + 8] ; source array
	mov     ebx, [ebp + 12] ; n
	mov     edi, [ebp + 16] ; dest array
	mov     edx, [ebp + 20] ; pointer to dest length

	;; DO NOT MODIFY
   

	;; Your code starts here
	mov eax, 0
	mov DWORD [edx], eax
	mov ecx, 0
delete_num:
	mov eax, DWORD [esi + ecx * 4]
	
	and eax, 1 ; verify if the number is even
	jnz delete

	mov eax, DWORD [esi + ecx * 4]; check if the number is power of 2
	push edx
	mov edx,  DWORD [esi + ecx * 4]
	dec edx
	and eax, edx
	jz delete_pop

	pop edx

	mov eax, DWORD [esi + ecx * 4] ; move the element in the array
	push ecx
	mov ecx, DWORD [edx]
	mov DWORD [edi + ecx * 4], eax
	mov eax, 1
	add [edx], eax

	pop ecx
	jmp delete
delete_pop:
	pop edx
delete:
	inc ecx
	cmp ecx, ebx
	je end_delete_num
	jmp delete_num
end_delete_num:
	;; Your code ends here
	

	;; DO NOT MODIFY

	popa
	leave
	ret
	
	;; DO NOT MODIFY
