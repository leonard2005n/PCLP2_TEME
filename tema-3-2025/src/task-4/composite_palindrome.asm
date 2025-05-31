extern calloc
extern strcat
extern strlen
extern strcpy
extern strcmp

section .bss
    ; the vector needed for the backtracking
    arr resd 20
    ; the string that stores the genereted string but not he final one
    aux resb 200

section .text
global check_palindrome
global composite_palindrome

check_palindrome:
    ; create a new stack frame
    enter 0, 0

    push esi
    push edi
    push edx
    push ecx
    push ebx

    xor eax, eax

    ; str
    mov esi, [ebp + 8]
    ; lenght
    mov edi, [ebp + 12]
    ; mov edx, edi
    mov eax, 1
    xor ecx, ecx
    xor ebx, ebx
    mov edx, edi
    dec edx
for:

    mov bl, byte [esi + ecx]
    mov bh, byte [esi + edx]

    cmp bh, bl
    je yes
    xor eax, eax
yes:

    ; dec edx
    inc ecx
    dec edx
    cmp ecx, edi
    je end_for
    jmp for
end_for:

    pop ebx
    pop ecx
    pop edx
    pop edi
    pop esi

    leave
    ret

    ; Function that checks if the genereted string is a plaindorm and
    ; if it respects the criterias to be stored as the best palindorme
    ; void check(int arr, char **vector, int len, char *out)
check:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax

    ; store the last stack frame
    push esi
    push edi
    push edx
    push ecx
    push ebx
    push eax

    ; arr
    mov ebx, [ebp + 8]
    ; array
    mov esi, [ebp + 12]
    ; len
    mov edi, [ebp + 16]
    inc edi

    ; put the pointer to the auxiliar string
    mov eax, aux

    ; initialize for the zeros for the reset the aux
    xor ecx, ecx
    ; resets the arr string
zeros:

    ; puts zero on the pos ecx in the arr
    mov byte [eax + ecx], 0

    inc ecx
    ; breacking for the zeros of the aux
    cmp ecx, 150
    je end_zeros
    jmp zeros
end_zeros:

    ; move the pos of the firs string
    mov ecx, dword [ebx + 4]
    ; gets the first string from the array of strings
    mov ecx, [esi + ecx * 4]

    push ecx
    push aux
    call strcpy
    ; delete the argumets
    add esp, 8

    ; move the pointer of the auxiliar string to the eax register
    mov eax, aux

    ; check if the array has more string than one
    mov ecx, 1
    cmp ecx, edi
    jge end_composite
composite:
    push ecx

    ; get the int for the string numerotated in the array of strings
    mov ecx, dword [ebx + ecx * 4 + 4]
    ; move the pointer of the string to the respective number
    mov ecx, [esi + ecx * 4]

    push ecx
    push aux
    call strcat
    ; delete the argumets
    add esp, 8

    mov eax, aux

    pop ecx
    inc ecx
    cmp ecx, edi
    je  end_composite
    jmp composite
end_composite:

    push aux
    call strlen
    ; delete the argumets
    add esp, 4

    ; lenght of the aux string
    mov ebx, eax

    push ebx
    push aux
    call check_palindrome
    ; delete the argumets
    add esp, 8

    ; check if the string aux is palindrome
    cmp eax, 0
    je false

true:
    ; get the vector for the output
    mov edx, [ebp + 20]

    push edx
    call strlen
    ; delete the argumets
    add esp, 4

    ; get the vector for the output
    mov edx, [ebp + 20]

    cmp ebx, eax
    jl false
    jg copy

    ; get the vector for the output
    mov edx, [ebp + 20]

    push edx
    push aux
    call strcmp
    ; delete the argumets
    add esp, 8

    ; get the vector for the output
    mov edx, [ebp + 20]

    ; compares if the aux is before the string we had stored for the solution
    cmp eax, 0
    jl copy
    jmp false
copy:

    push aux
    push edx
    call strcpy
    ; delete the argumets
    add esp, 8
    jmp false
false:

    ; restore the last stack frame
    pop eax
    pop ebx
    pop ecx
    pop edx
    pop edi
    pop esi

    leave
    ret

    ; void back_tracking(int arr, char **vector, int len, int k, char *out)
back_tracking:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax

    ; store the last stack frame
    push esi
    push edi
    push edx
    push ecx
    push ebx

    ; arr
    mov ebx, [ebp + 8]
    ; vector of strings
    mov esi, [ebp + 12]
    ; lenght of the vector of strigns
    mov edi, [ebp + 16]
    ; this is k
    mov edx, [ebp + 20]
    ; get the array of output
    mov eax, [ebp + 24]

    ; initilazie the ecx register with the value before +1 for the backtracking
    mov ecx, dword [ebx + edx * 4]
    inc ecx

    cmp ecx, edi
    jge end_for2

for2:

    ; put the position of the char on the arr of the backtracking
    mov dword [ebx + edx * 4 + 4], ecx

    ; get the vector for the output
    mov eax, [ebp + 24]

    push eax
    push edx
    push esi
    push ebx
    call check
    ; delete the argumets
    add esp, 16

    ; get the vector for the output
    mov eax, [ebp + 24]

    push eax
    inc edx
    push edx
    dec edx
    push edi
    push esi
    push ebx
    call back_tracking
    ; delete the argumets
    add esp, 20



    inc ecx
    cmp ecx, edi
    je end_for2
    jmp for2
end_for2:


    ; restore the last stack frame
    pop ebx
    pop ecx
    pop edx
    pop edi
    pop esi

    leave
    ret

composite_palindrome:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax

    ; store the last stack frame
    push esi
    push edi
    push edx
    push ecx
    push ebx

    ; initialiaze the arr vector fo the eax
    mov eax, -1
    mov dword [arr], eax

    ; is the sizeof(char) for the calloc
    mov ebx, 1
    push ebx
    ; is the size of the calloc
    mov ebx, 300
    push ebx
    call calloc
    ; delete the argumets
    add esp, 8
    push eax

    ; vector of strings
    mov esi, [ebp + 8]
    ; lenght
    mov edi, [ebp + 12]
    ; initilaize the level for the backtracking
    mov edx, 0

    push eax
    push edx
    push edi
    push esi
    push arr
    call back_tracking
    ; delete the argumets
    add esp, 20

    pop eax

    ; restore the last stack frame
    pop ebx
    pop ecx
    pop edx
    pop edi
    pop esi

    leave
    ret
