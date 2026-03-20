%include "./pc_io.inc"

global _start

section .data
    msj: db 'Texto: ',0x0
    msj1: db 'La letra se encontro en posicion #',0x0
    msj2: db 'La letra se encontro # veces',0x0
    msj3: db 'Hay # @',0x0
    msj4: db 'Se encontro # vocales',0x0

section .bss   
    cad1: resb 30
    cad2: resb 30

section .text
    _start:

    ;SUBRUTINA 1
    mov edx, msj
    call puts

    mov edx, cad1
    call capturar
    call buscar


    ;SUBRUTINA 2
    mov edx, msj
    call puts

    mov edx, cad1
    call capturar
    mov edi, cad2
    call invertir

    mov edx, edi
    call puts
    call salto
    
    ;SUBRUTINA 3
    mov edx, msj
    call puts

    mov edx, cad1
    call capturar
    call mayusculas
    call puts
    call salto

    ;SUBRUTINA 4
    mov edx, msj
    call puts

    mov edx, cad1
    call capturar
    call vocales


    mov eax, 1
    mov ebx, 0
    int 80h

buscar:
    pushad

    mov esi, 0
    mov ah, 0

    call getche
    call salto

    .buscar:
        cmp byte[edx+esi], 0
        je .salirBuscar

        cmp byte[edx+esi], al
        jne .saltar

        mov ebx, esi
        add bl, '0'
        push edx
        mov edx, msj1
        mov [edx+33], bl
        call puts
        call salto
        pop edx
        inc ah
        
        .saltar:
        inc esi

    jmp .buscar

    .salirBuscar:
    add ah, '0'
    mov edx, msj2
    mov [edx+21], ah

    call puts
    call salto
  
    popad
    ret

invertir:
    pushad

    mov esi, 0
    
    .conteo:
        cmp byte[edx+esi], 0
        je .salirConteo
        inc esi
    jmp .conteo

    .salirConteo:

    mov ecx, 0

    cmp esi, 0
    je .salirInvertir

    .invertir:
        dec esi
        
        mov al, byte[edx+esi]
        mov [edi+ecx], al

        inc ecx 

        cmp esi, 0
        je .salirInvertir
    jmp .invertir 

    .salirInvertir:
    mov byte[edi+ecx], 0

    popad
    ret

mayusculas:
    pushad

    mov esi, 0

    .mayuscula:
        cmp byte[edx+esi], 0
        je .salirMayuscula

        sub byte[edx+esi], 32

        inc esi
    jmp .mayuscula

    .salirMayuscula:

    popad
    ret

vocales:
    pushad

    mov eax, 0

    mov eax, 'u'
    push eax
    mov eax, 'o'
    push eax
    mov eax, 'i'
    push eax
    mov eax, 'e'
    push eax
    mov eax, 'a'
    push eax

    mov bh, 0 ;CONTADOR TOTAL DE VOCALES

    mov ecx, 5

    .vocal:
        mov esi, 0
        mov bl, 0 ;CONTADOR DE VOCALES INDIVIDUALES
        pop eax ;CARGA EL VOCAL EN AL

        .buscar:
            cmp byte[edx+esi], 0
            je .salirBuscar

            cmp byte[edx+esi], al 
            jne .saltar

            inc bl
            inc bh

            .saltar:
            inc esi
        jmp .buscar

        .salirBuscar:
        push edx
        mov edx, msj3
        add bl, '0'
        mov [edx+4], bl
        mov [edx+6], al
        call puts
        call salto
        pop edx

    loop .vocal

    mov edx, msj4
    add bh, '0'
    mov [edx+12], bh
    call puts
    call salto

    popad
    ret

capturar:
        pushad

        mov esi, 0          ;INDICE DE LA CADENA EN AUMENTO

        .captura:
            call getche         ;CAPTURA DE CARACTER Y ECO
            cmp al, 10          ;if (CARACTER == \n)
            je .salirCaptura
            mov [edx+esi], al
            inc esi
        jmp .captura
    
        .salirCaptura:
        mov byte[edx+esi], 0    ;PONE 0 EN EL ULTIMO SLOT

        popad
        ret

salto: 
    pushad 
    
    mov al, 13 
    call putchar 
    mov al, 10 
    call putchar 
    
    popad 
    ret 
