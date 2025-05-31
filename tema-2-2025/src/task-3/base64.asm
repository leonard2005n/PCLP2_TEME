%include "../include/io.mac"

extern printf
global base64

section .data
	alphabet db 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
	fmt db "%d", 10, 0

section .text

base64:
	;; DO NOT MODIFY

    push ebp
    mov ebp, esp
	pusha

	mov esi, [ebp + 8] ; source array
	mov ebx, [ebp + 12] ; n
	mov edi, [ebp + 16] ; dest array
	mov edx, [ebp + 20] ; pointer to dest length

	;; DO NOT MODIFY


	; -- Your code starts here --
	mov eax, 0
	mov DWORD [edx], eax
	mov ecx, 0
for:
	push ebx
	xor eax, eax
	
	mov ah, BYTE [esi + ecx] ; gets the first 6 bits in ebx
	inc ecx
	shr eax, 2
	movzx ebx, ah

	push ecx
	mov ecx, DWORD [edx]
	mov bl, BYTE [alphabet + ebx]
	mov BYTE [edi + ecx], bl ; puts the value in the array
	inc ecx
	mov DWORD [edx], ecx
	pop ecx

	xor ah, ah  ;gets the scond 6 bits in ebx
	shl eax, 2
	mov al, BYTE [esi + ecx]
	inc ecx
	shl eax, 4
	movzx ebx, ah

	push ecx
	mov ecx, DWORD [edx]
	mov bl, BYTE [alphabet + ebx]
	mov BYTE [edi + ecx], bl ; puts the value in the array
	inc ecx
	mov DWORD [edx], ecx
	pop ecx

	xor ah, ah
	shl eax, 4
	mov al, BYTE [esi + ecx] ;gets the third 6 bits in ebx
	inc ecx
	shl eax, 2
	movzx ebx, ah

	push ecx
	mov ecx, DWORD [edx]
	mov bl, BYTE [alphabet + ebx]
	mov BYTE [edi + ecx], bl ; puts the value in the array
	inc ecx
	mov DWORD [edx], ecx
	pop ecx

	xor ah, ah
	shl eax, 6 ; gets the forth 6 bits in ebx
	movzx ebx, ah
	
	push ecx
	mov ecx, DWORD [edx]
	mov bl, BYTE [alphabet + ebx]
	mov BYTE [edi + ecx], bl ; puts the value in the array
	inc ecx
	mov DWORD [edx], ecx
	pop ecx

	pop ebx
	cmp ecx, ebx
	jge end
	jmp for

end:

	; -- Your code ends here --'


	;; DO NOT MODIFY

	popa
	leave
	ret

	;; DO NOT MODIFY