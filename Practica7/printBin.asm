%include "./pc_io.inc"

global _start

section .data

section .bss

section .text

_start:

mov eax, 12345664h
call printBin

mov eax, 1
mov ebx, 0
int 80h

printBin:
    pushad
    mov ecx, 32
    mov ebx, eax

    .rotacion:
    rcl ebx, 1
    jc .uno
    mov al, '0'
    call putchar
    jmp .continue
    .uno: 
    mov al, '1'
    call putchar
    .continue:
    loop .rotacion
    mov eax, ebx

popad
ret
