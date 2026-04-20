
%include "./pc_io.inc"

global _start

section .data

section .bss
    cad: resb 100       ;CADENA INGRESADA POR EL USUARIO
    dirs: resd 50       ;DIRECCIONES DEL INICIO DE CADA PALABRA
    tam: resb 50        ;NUMERO DE LETRAS DE CADA PALABRA
    simbolos: resb 100  ;NOSE
    hex: resb 10 

section .text

_start:

call capturar
call direcciones
call tamanio
call mostrar

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
        mov [cad+esi], al
        inc esi
    jmp .captura

    .salirCaptura:
    mov byte[cad+esi], 0

    popad
    ret

direcciones:
    pushad
    
    mov esi, 0
    mov edi, 0
    mov eax, 1 ;Bandera de palabra

    .recorrer:
        cmp byte[cad+esi], 0    ;SALE DEL CICLO DESPUES DE LLEGAR AL FINAL DE CAD
        je .salirRecorrer

        cmp eax, 1  ;REVISA LA BANDERA DE PALABRA PARA GUARDAR LA DIRECCION
        jne .seguir
        
        lea ebx, [cad+esi]
        mov [dirs+edi*4], ebx
        inc edi
        mov eax, 0

        .seguir:

        cmp byte[cad+esi], 32   ;REVISA SI HAY ESPACIO PARA LEVANTAR LA BANDERA DE PALABRA 
        jne .saltar

        mov eax, 1

        .saltar:
        inc esi
        
    jmp .recorrer

    .salirRecorrer:
    mov dword[dirs+edi*4], 0

    popad
    ret

tamanio:
    pushad

    mov esi, 0

    .recorrer:
        mov ebx, [dirs+esi*4]   ;COPIA LA DIRECCION DE LA PRIMERA LETRA DE CADA PALABRA

        cmp ebx, 0  ;SALE DEL CICLO DESPUES DE LLEGAR A LA ULTIMA PALABRA
        je .finRecorrer

        push esi

        mov esi, 0

        .conteo:    
            cmp byte[ebx+esi], 32
            je .finConteo

            cmp byte[ebx+esi], 0
            je .finConteo

            inc esi     ;CUENTA HASTA ENCONTRAR UN ESPACIO O 0
        jmp .conteo
        .finConteo:
        mov eax, esi
        pop esi
        mov [tam+esi], al
        inc esi

    jmp .recorrer

    .finRecorrer:
    mov byte[tam+esi], 0

    popad
    ret

mostrar:
    pushad

    mov esi, 0
    mov ecx, 0
    mov eax, 0

    .recorrer:
        mov ebx, [dirs+esi*4]

        cmp ebx, 0     ;SALE DEL CICLO CUANDO LLEGA A LA ULTIMA DIRECCION
        je .finRecorrer

        push esi    ;MOSTRAR DIRECCION DE LA PRIMERA LETRA DE LA PALABRA
        mov eax, ebx
        mov esi, hex
        call printHex
        pop esi

        call espacio

        mov cl, [tam+esi]
        mov al, [tam+esi]

        add al, '0'
        call putchar

        call espacio

        push esi
        mov esi, 0
        .escribir:
            mov al, [ebx+esi]
            call putchar
            inc esi
        loop .escribir

        pop esi
        inc esi
       
       mov al, 10
       call putchar
    jmp .recorrer

    .finRecorrer:

    popad
    ret

printHex:
  pushad
  mov edx, eax
  mov ebx, 0fh
  mov cl, 28
.nxt: shr eax,cl
.msk: and eax,ebx
  cmp al, 9
  jbe .menor
  add al,7
.menor:add al,'0'
  mov byte [esi],al
  inc esi
  mov eax, edx
  cmp cl, 0
  je .print
  sub cl, 4
  cmp cl, 0
  ja .nxt
  je .msk
.print: mov eax, 4
  mov ebx, 1
  sub esi, 8
  mov ecx, esi
  mov edx, 8
  int 80h
  popad
  ret

espacio:
    pushad

    mov al, ' '
    call putchar
    mov al, '-'
    call putchar
    mov al, ' '
    call putchar

    popad
    ret
