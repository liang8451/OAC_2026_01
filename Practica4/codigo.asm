%include "./pc_io.inc"

global _start

section .data
    msj: db 'Texto: ',0x0
    msj2: db 'Es palindromooo',0x0
    msj3: db 'No es palindromo', 0x0
section .bss
    texto: resb 20


section .text
_start:
    mov edx, msj 
    call puts

    mov edx, texto
    call capturar
    call palindromo
    call salto

    mov edx, texto
    call puts

    mov eax, 1
    mov ebx, 0
    int 80h

capturar:
        pushad

        mov esi, 0          ;INDICE DE LA CADENA EN AUMENTO

        .captura:
        call getche         ;CAPTURA DE CARACTER Y ECO
        cmp al, 10          ;if (CARACTER == \n){PONE 0 EN EL ULTIMO SLOT}
        je .salirCaptura
        mov [edx+esi], al
        inc esi
        jmp .captura
    
        .salirCaptura:
        mov byte[edx+esi], 0

        popad
        ret

palindromo:
        pushad
    
        mov esi, 0

        .longitud:
            cmp byte[edx+esi], 0
            je .salirLongitud
            inc esi
            jmp .longitud
    
        .salirLongitud:
        mov ebx, esi
        sub ebx, 1 ;NUMERO DE LETRAS -1
        mov esi, 0 ;CONTADOR DE RECORRIDO
    
        .palindromo:
        mov al, byte[edx+esi] ; LETRAS EMPEZANDO DE LA IZQUIERDA
        mov edi, ebx
        sub edi, esi
        mov ah, byte[edx+edi] ; LETRAS EMPEZANDO DE LA DERECHA
        cmp al, ah
        jne .noPalindromo       ;NO ES PALINDROMO SI NO SON IGUALES
        cmp esi, ebx            
        je .esPalindromo        ;ES PALINDROMO SI NO SE ENCONTRO NINGUNA DIFERENCIA
        inc esi
        jmp .palindromo

        .esPalindromo:
        mov edx, msj2
        call puts
        popad
        ret

        .noPalindromo:
        mov edx, msj3
        call puts
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
