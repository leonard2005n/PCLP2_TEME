struc node
    .val resd 1 ; the value
    .next resd 1  ; pointer to the next node
endstruc

section .text
global sort

;   struct node {
;    int val;
;    struct node* next;
;   };

;; struct node* sort(int n, struct node* node);
;   The function will link the nodes in the array
;   in ascending order and will return the address
;   of the new found head of the list
; @params:
;   n -> the number of nodes in the array
;   node -> a pointer to the beginning in the array
;   @returns:
;   the address of the head of the sorted list
sort:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax

    push esi
    push edi
    push edx
    push ecx
    push ebx

    ; numbers of nodes
    mov edi, [ebp + 8]
    ; the list
    mov esi, [ebp + 12]
    ; is for making the for 
    xor ecx, 0
    ; this is to determin the minimum of the entire array
    mov ebx, 0xFFFFFFFF
    xor edx, edx

iteration:
    push edx
    push ebx
    push ecx

    ; gets the node to determine his next
    lea eax, [esi + ecx * node_size]
    push eax

    mov eax, [eax + ecx * node.val]

    xor ecx, ecx
    ; initialize to determine the best candidate for the node
    mov ebx, 0xFFFFFFFF 
    xor edx, edx

for:  ; determine his next
    push edi

    lea edi, [esi + ecx * node_size]

    cmp eax, [edi + node.val]
    jge skip

    cmp ebx, [edi + node.val]
    jb skip

    ; store the best minimum node for are current node
    lea edx, [esi + ecx * node_size]
    mov ebx, [edi + node.val]

skip:
    pop edi

    inc ecx
    cmp ecx, edi
    je end_for
    jmp for
end_for:

    pop eax
    ; copy the addres to the next
    mov [eax + node.next], edx 
    pop ecx

    pop ebx
    pop edx

    cmp ebx, [eax + node.val]
    jb not_minimum
    ; store the minimu node of the entire array
    mov edx, eax
    mov ebx, [edx + node.val]
not_minimum:

    inc ecx
    cmp ecx, edi

    je end_iteration
    jmp iteration
end_iteration:

    lea eax, [edx]

    pop ebx
    pop ecx
    pop edx
    pop edi
    pop esi

    leave
    ret

