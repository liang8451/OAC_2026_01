%include "./pc_io.inc"

global _start

section .data
    msj: db 'Texto: ',0x0
    msj2: db 'Es palindromooo',0x0
    msj3: db 'No es palindromo', 0x0
section .bss
    texto: rest 2
    largo: resb 1


section .text
_start:
    mov edx, msj 
    call puts

    mov ebx, texto
    call capturar

    mov ebx, texto
    call palindromo
    call salto

    mov edx, texto
    call puts

    mov eax, 1
    mov ebx, 0
    int 80h






capturar:
        pushad

        mov esi, 0

        .captura:
        call getche
        cmp al, 10
        je .salirCaptura
        mov [ebx+esi], al
        inc esi
        jmp .captura
    
        .salirCaptura:
        mov al, 0
        mov [ebx+esi], al

        mov ebx, largo
        mov [ebx], esi

        popad
        ret

palindromo:
    pushad
    mov esi, 0
    mov al, 0 ;PORQUEEEEEE

    ;.longitud:
    ;    cmp byte[ebx+esi], al
    ;    je .salirLongitud
    ;    inc esi
    ;
    ;    jmp .longitud
    ;
    ;.salirLongitud:

    mov esi, largo
    mov esi, [esi]

    mov edx, esi
    sub edx, 1 ;NUMERO DE LETRAS -1

    mov edi, ebx
    add edi, edx ;POSICION FINAL DE LA CADENA

    mov esi, ebx ;POSICION INICIAL DE LA CADENA
    
    mov ecx, 0 ;CONTADOR DE RECORRIDO
    .palindromo:


    mov al, byte[esi+ecx] ; LETRAS EMPEZANDO DE LA IZQUIERDA
   
    mov ebx, edx
    sub ebx, ecx

    mov ah, byte[esi+ebx] ; LETRAS EMPEZANDO DE LA DERECHA
    cmp al, ah
    jne .noPalindromo

    cmp ecx, edx
    je .esPalindromo


    inc ecx
    jmp .palindromo


    .esPalindromo:
    mov edx, msj2
    call puts
    popad
    ret

    .noPalindromo:
    ;mov eax, 0
    ;mov eax,ecx
    ;add eax, '0'
    ;call  putchar
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
