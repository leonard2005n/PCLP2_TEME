section .text
global kfib

kfib:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax

    push esi
    push edi
    push edx
    push ecx
    push ebx

    ; it is N
    mov ecx, [ebp + 8]
    ; it is K
    mov ebx, [ebp + 12]

    cmp ecx, ebx
    je one_case
    jl zero_case

    xor edx, edx
    xor esi, esi
    dec ecx

    ; this it the for to call all the need recursive functions
for:

    push ebx
    push ecx
    call kfib
    ; delets the arguments of the call
    add esp, 8

    add edx, eax

    dec ecx
    inc esi
    cmp esi, ebx
    je end_for
    jmp for
end_for:
    mov eax, edx

    jmp exit
zero_case:
    ; if the N is lower than K
    xor eax, eax
    jmp exit
one_case:
    ; if the N is equal than K
    mov eax, 1
exit:

    pop ebx
    pop ecx
    pop edx
    pop edi
    pop esi

    leave
    ret
