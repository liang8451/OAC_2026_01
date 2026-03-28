%include "./pc_io.inc"

global _start

section .data
    texto1: db 'CONTEO DE PALABRAS',0xA,'Ingrese una oracion: ',0x0 
    texto2: db 'Hay # palabras', 0x0A, 0x0

section .bss
    cad1: resq 10

section .text

_start:

    mov edx, texto1
    call puts

    mov edx, cad1
    call capturar

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

    mov esi, 0
    mov eax, 0

    .recorrido:
        cmp byte[edx+esi], 0
        je .salirRecorrido

        cmp byte[edx+esi], ' '
        jne .continue

        inc eax

        .continue:
        inc esi
    jmp .recorrido

    .salirRecorrido:

    cmp esi, 0
    je .sinPalabras

    inc eax

    .sinPalabras:

    add eax, '0'
    mov [texto2+4], al

    mov edx, texto2
    call puts

    popad
    ret
