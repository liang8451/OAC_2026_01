%include "./pc_io.inc"

global _start

section .data
    texto1: db 'COMPARACION DE CADENAS',0xA,'Ingrese una cadena: ',0x0
    texto2: db 'Son palabras iguales', 0xA, 0x0
    texto3: db 'No son palabras iguales', 0xA, 0x0

section .bss
    cad1: resw 10
    cad2: resw 10

section .text

_start:

    mov edx, texto1
    call puts

    mov edx, cad1
    call capturar

    mov edx, texto1+23
    call puts

    mov edx, cad2
    call capturar

    mov ecx, cad1
    mov edx, cad2
    call comparar


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

comparar:
    pushad
    mov esi, 0
    mov eax, 1 ;BANDERA DE IGUALDAD

    .comparar:
        mov bl, [ecx+esi]
        mov bh, [edx+esi]

        cmp bl, bh  
        jne .noIguales

        cmp bl, 0
        je .iguales

        inc esi
    jmp .comparar

    .iguales:
    mov edx, texto2
    call puts

    popad
    ret

    .noIguales:

    mov edx, texto3
    call puts

    popad
    ret
