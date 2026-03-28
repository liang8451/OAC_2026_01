%include "./pc_io.inc"

global _start

section .data
    texto1: db 'Ingrese una cadena: ',0x0
    texto2: db 'Ingrese un caracter: ',0x0
    tabla: db '0123456789' 

section .bss
    cad1: resw 10

section .text

_start:

    mov edx, texto1
    call puts

    mov edx, cad1
    call capturar 

    mov edx, texto2
    call puts
    call getche

    mov edx, cad1
    call conteo

    mov eax, 1
    mov ebx, 0
    int 80h

capturar:
    pushad

    mov esi, 0

    .capturar:
        call getche

        cmp al, 10
        je .salirCapturar

        mov [edx+esi], al

        inc esi
    jmp .capturar

    .salirCapturar:

    mov byte[edx+esi], 0

    popad
    ret

conteo:
    pushad

    mov ah, al

    mov al, 10
    call putchar

    mov al, 0

    mov ebx, tabla

    mov esi, 0

    .contar:
        cmp byte[edx+esi], 0
        je .salirContar

        cmp [edx+esi], ah
        jne .continue

        inc al

        .continue:

        inc esi
    jmp .contar

    .salirContar:

    xlat
    call putchar

    popad
    ret
