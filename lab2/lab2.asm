global _start

section .data
element_size equ 4
buf1 dd 0x01, 0x80, 0x48000
len equ ($-buf1)
LF db 0xa

section .bss
buf2 resd len / element_size


section .text
; void print_dword(DWORD x)
print_dword:
    push ebp
    mov ebp, esp

    sub esp, 1

    xor ecx, ecx
.next_iter:
    mov ebx, 10
    xor edx, edx
    div ebx
    add edx, '0'
    push edx
    inc ecx
    cmp eax, 0
    je .print_iter
    jmp .next_iter
.print_iter:
    cmp ecx, 0
    je .close
    pop eax

    push eax
    push ebx
    push ecx
    push edx

    mov [ebp+1], al
    mov eax, 4
    mov ebx, 1
    lea ecx, [ebp+1]
    mov edx, 1
    int 0x80

    pop edx
    pop ecx
    pop ebx
    pop eax

    dec ecx
    jmp .print_iter
.close:

    mov eax, 4
    mov ebx, 1
    mov ecx, LF
    mov edx, 1
    int 0x80

    mov esp, ebp
    pop ebp
    ret


; void process(DWORD dst, DWORD src, DWORD n)
process:
    push ebp
    mov ebp, esp

    mov edi, [ebp+8]
    mov esi, [ebp+12]
    mov ecx, [ebp+16]
.lp:
    lodsb
    bt eax, 0x7
    jnc .next
    shr al, 0x1
.next
    stosb
    loop .lp

    mov esp, ebp
    pop ebp
    ret


; DWORD sum(DWORD buf, DWORD n) 
sum:
    push ebp
    mov ebp, esp

    mov esi, [ebp+8]
    mov ecx, [ebp+12]
    xor eax, eax
.lp:
    add eax, [esi]
    add esi, 4
    loop .lp

    mov esp, ebp
    pop ebp
    ret


_start:
    push len
    push buf1
    push buf2
    call process
    add esp, 12

    push len / element_size
    push buf2
    call sum
    add esp, 8

    push eax
    call print_dword
    add esp, 4

    mov eax, 1
    mov ebx, 0
    int 0x80


