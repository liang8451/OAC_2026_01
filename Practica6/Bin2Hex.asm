%include "./pc_io.inc"

global _start

section .data
    texto: db 'Ingrese un numero en binario: ',0x0

section .bss
    binario: resq 4
    room: resd 1

section .text

_start:
    mov edx, texto
    call puts

    mov edx, binario
    call capturar

    call convertir

    mov eax, 1
    mov ebx, 0
    int 80h

convertir:
    pushad

    mov esi, 0
    mov bl, 0 ;ACUMULADOR
    mov bh, 2 ;BASE

    .longitud:
        cmp byte[edx+esi], 0
        je .salirLongitud

        inc esi
    jmp .longitud

    .salirLongitud:

    cmp esi, 0
    je .salir

    dec esi
    mov edi, esi

    mov esi, 0

    .recorrido:
        cmp byte[edx+esi], '1'
        jne .continue

        cmp edi, 0
        jne .saltar

        add bl, 1               ;SI LA POTENCIA ES 0, SE LE SUMA UNO AL ACUMULADOR
        jmp .salir              ;Y TERMINA LA SUMA

        .saltar:
        cmp edi, 1
        jne .potencia

        add bl, bh              ;SI LA POTENCIA ES 1, SE LE SUMA LA BASE AL ACUMULADOR
        jmp .continue           ;PASA AL SIGUIENTE DIGITO

        .potencia:

            mov ecx, edi
            dec ecx
            mov al, bh

            .multiplicar:
                mul bh
            loop .multiplicar

            add bl, al 
            
        .continue:

        cmp edi, 0
        je .salir

        inc esi
        dec edi
    jmp .recorrido

    .salir:

    movzx eax, bl
    mov esi, room

    call printHex

    mov al, 10
    call putchar 

    popad
    ret


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
