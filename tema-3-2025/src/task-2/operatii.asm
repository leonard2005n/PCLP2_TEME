section .text
global sort
global get_words

extern qsort
extern strlen
extern strcmp

compare:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax

    push esi
    push edi
    push edx
    push ecx
    push ebx

    ; first string
    mov esi, [ebp + 8]
    ; first string
    mov edi, [ebp + 12]
    mov esi, [esi]
    mov edi, [edi]

    ; get the lenght of the first string
    push esi
    call strlen
    ; delete the argumets
    add esp, 4

    mov ebx, eax

    push ebx

    ; get the lenght of the second string
    push edi
    call strlen
    ; delete the argumets
    add esp, 4

    pop ebx

    cmp eax, ebx
    jg greater
    jl lower


    push edi
    push esi
    call strcmp
    ; delete the argumets
    add esp, 8
    jmp exit


greater:
    ; if the first string is lower than the second
    mov eax, -1
    jmp exit
lower:
    ; if the first string is greater than the second
    mov eax, 1
exit:

    pop ebx
    pop ecx
    pop edx
    pop edi
    pop esi

    leave
    ret


;; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor
;  dupa lungime si apoi lexicografix
sort:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax

    push esi
    push edi
    push edx
    push ecx
    push ebx

    ; vector of strings
    mov esi, [ebp + 8]
    ; number_of_words
    mov edi, [ebp + 12]
    ; size
    mov edx, [ebp + 16]

    ; call qsort
    push compare
    push edx
    push edi
    push esi
    call qsort
    ; delete the argumets
    add esp, 16


    pop ebx
    pop ecx
    pop edx
    pop edi
    pop esi

    leave
    ret

;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte
get_words:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax

    push esi
    push edi
    push edx
    push ecx
    push ebx

    ; string
    mov esi, [ebp + 8]
    ; vector of strings
    mov edi, [ebp + 12]
    ; number of strinsgs
    mov edx, [ebp + 16]
    xor ecx, ecx
    xor eax, eax

words:

    ; this for is to position on the firs letter of the word
posittion:

    movzx ebx, byte [esi]

    cmp ebx, ' '
    je pass

    cmp ebx, ','
    je pass

    ; checks if the character is \n
    cmp ebx, 10
    je pass

    ; checks if the character is NULL
    cmp ebx, 0
    je end_words

    jmp end_position

pass:

    inc esi
    jmp posittion
end_position:

    ; puts the addres of the word in the array of strings
    mov [edi + eax * 4], esi

    ; this is to put null when it will end the word
copy:

    movzx ebx, byte[esi]

    cmp ebx, ' '
    je end_copy

    cmp ebx, ','
    je end_copy

    ; checks if the character is \n
    cmp ebx, 10
    je end_copy

    ; checks if the character is NULL
    cmp ebx, 0
    je end_copy

    inc esi
    jmp copy
end_copy:

    ; put NULL at the end of the word
    mov byte [esi], 0

    inc eax
    inc esi
    dec edx
    ; checks if their are more word to find
    cmp edx, 0
    je end_words
    jmp words
end_words:

    pop ebx
    pop ecx
    pop edx
    pop edi
    pop esi

    leave
    ret

