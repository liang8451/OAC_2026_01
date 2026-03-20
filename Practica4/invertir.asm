%include "./pc_io.inc"

global _start

section .data
    msj: db 'Texto: ',0x0
section .bss
    cad: resb 30
    largo: resb 1

section .text
    _start:

    mov edx, msj
    call puts

    mov edx, cad

    call capturar
    call invertir
    call escribir

    call salto

    mov eax, 1
    mov ebx, 0
    int 80h

    invertirConXCHG:
        pushad

        mov ebx, largo
        mov edi, [ebx]
        sub edi, 1 
        mov esi, 0

        .invertir:
            cmp esi, edi ;COMPARAR PARA CASO IMPAR
            je salirInvertir
            
            mov al, [edx+esi] ;APUNTA AL PRIMER CARACTER
            mov ah, [edx+edi] ;APUNTA AL ULTIMO CARACTER
            xchg al, ah
            mov [edx+esi], al
            mov [edx+edi], ah

            inc esi
            
            cmp esi, edi ;COMPARAR PARA CASO PAR
            je salirInvertir

            dec edi

        jmp .invertir

        salirInvertir:

        popad
        ret


    invertir:
        pushad
        
        mov ebx, largo
        mov edi, [ebx]
        sub edi, 1
        mov esi, 0

        .invertir:
            cmp esi, edi
            je .salirInvertir

            mov al, [edx+esi]
            mov ah, [edx+edi]
            mov [edx+edi], al
            mov [edx+esi], ah 

            inc esi

            cmp esi,edi
            je .salirInvertir

            dec edi

        jmp .invertir

        .salirInvertir:

        popad
        ret

   

    capturar:
        pushad

        mov esi, 0          ;INDICE DE LA CADENA EN AUMENTO

        .captura:
        call getche         ;CAPTURA DE CARACTER Y ECO
        cmp al, 10         ;if (CARACTER == \n){PONE 0 EN EL ULTIMO SLOT}
        je .salirCaptura
        mov [edx+esi], al
        inc esi
        jmp .captura
    
        .salirCaptura:
        mov byte[edx+esi], 0

        mov ebx, largo 
        mov [ebx], esi

        popad
        ret


    escribir:
        pushad

        mov esi, 0

        .escribir:
        mov al, [edx+esi]
        cmp al, 0 ;CARACTER ESPECIAL DE TERMINACION
        je .salirEscribir
        inc esi
        call putchar
        jmp .escribir

        .salirEscribir:

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
