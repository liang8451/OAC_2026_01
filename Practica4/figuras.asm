%include "./pc_io.inc"

global _start

section .data

section .bss

section .text

_start:

;PROGRAMA ARBOLITO

    call getche                     ;RECIBE UN CARACTER EN al
    sub al, '0'                     ;CONVIERTE EL CARACTER EN al EN NUMERO
    
    mov ch, al                      ;ch GUARDA EL NUMERO DE RENGLONES

    mov al, '*'
    arbolitoVertical:
        cmp ch, 0                   
        je finArbolitoVertical      ;TERMINA LA EJECUCION DE ARBOLITO SI ch ES 0
        call salto
        mov cl, ch                  ;NUMERO DE COLUMNAS = NUMERO DE RENGLONES FALTANTES

            arbolitoHorizontal:
                cmp cl, 0
                je finArbolitoHorizontal        ;TERMINA LA EJECUCION SI cl ES 0
                call putchar                    
                dec cl                          ;VA DECREMENTANDO cl
            jmp arbolitoHorizontal
            
            finArbolitoHorizontal:

        dec ch                      ;VA DECREMENTANDO ch
    jmp arbolitoVertical
    
    finArbolitoVertical:



call salto  ;TERMINA PROGRAMA ARBOLITO
; SE USO al, ch, cl

;PROGRAMA CAJA

    call getche              ;RECIBE UN CARACTER EN al
    sub al, '0'              ;CONVIERTE CARACTER A NUMERO
    call salto
    
    mov ah, al              ;EL NUMERO INGRESADO SE GUARDA PERMANENTEMENTE EN ah
    mov cl, ah              ;cl GUARDA EL NUMERO INGRESADO

    cmp cl, 0               ;SI EL NUMERO INGRESADO ES 0, TERMINA PROGRAMA CAJA
    je finFondo

    mov al, '*'
    tapa:                   ;CICLO PARA PONER LA TAPA
        cmp cl, 0           ;TERMINA LA EJECUCION SI cl es 0
        je finTapa
        call putchar
        dec cl
    jmp tapa

    finTapa:

    call salto              
    mov cl, ah

    dec cl                  ;SI NUMERO INGRESADO ES 1, TERMINA PROGRAMA CAJA
    cmp cl, 0
    je finFondo

    dec cl                  ;SI NUMERO INGRESADO ES 2, PASA A PONER EL FONDO
    cmp cl, 0               ;cl AHORA TIENE EL LARGO DEL ESPACIO DENTRO DE LA CAJA       
    je fondo

    mov dl, cl               ;dl TIENE EL EL NUMERO DE RENGLONES           
    lateral:
        ;mov al, '|'
        cmp dl, 0            ;TERMINA LA EJECUCION DE LOS LATERALES SI dl ES 0
        je finLateral
        call putchar           ;PONE PRIMERO UNA LATERAL
        
        mov dh, cl          ;dh TIENE EL NUMERO DE COLUMNAS
        mov al, ' '
        llenar:
            cmp dh, 0
            je finLlenar    ;TERMINA LA EJECUCION DE LLENADO SI dh ES 0
            call putchar
            dec dh          ;dh VA DECREMENTANDO
        jmp llenar

        finLlenar:
        
        
        mov al, '*'
        call putchar
        call salto
        dec dl              ;dl VA DECREMENTANDO
    jmp lateral

    finLateral:

    fondo:          
        ;mov al, '-'
        cmp ah, 0
        je finFondo
        call putchar
        dec ah
    jmp fondo

    finFondo:

call salto
mov eax, 1
mov ebx, 0
int 80h

salto: 
pushad 
mov al, 13 
call putchar 
mov al, 10 
call putchar 
popad 
ret 
