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

section .data
	fmt db "%s", 10, 0
	months_day db 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31

section .text
    global check_events
    extern printf
	extern puts

check_events:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov ebx, [ebp + 8]      ; events
    mov ecx, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here
	mov esi, 0

for:
	lea eax, [ebx + esi + event.date]

	mov dx, WORD [eax + date.year] ; verify date

	cmp dx, 1990
	jl not_valid

	cmp dx, 2030
	jg not_valid

	mov dl, BYTE [eax + date.month] ; verify month

	cmp dl, 1
	jl not_valid

	cmp dl, 12
	jg not_valid

	movzx edx, BYTE [eax + date.month]
	movzx edx, BYTE [months_day + edx - 1] ; verify days
	movzx eax, BYTE [eax + date.day]

	cmp eax, edx
	jg not_valid

	cmp eax, 1
	jl not_valid

	lea eax, [ebx + esi + event.valid] ; modify the valid statement
	mov dl, 1
	mov BYTE [eax], dl

not_valid:
	add esi, event_size
	dec ecx
	cmp ecx, 0
	je end
	jmp for
end:
    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY