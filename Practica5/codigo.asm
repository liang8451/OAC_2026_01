%include "./pc_io.inc"

global _start

section .data

section .bss
    ;largo: resb 1
section .text

_start:
    call getche
    sub al, '0'
    
    mov cl, al

    mov al, '*'
    arbolitoVertical:
        cmp cl, 0
        je finArbolitoVertical
        call salto
        mov ch, cl

            arbolitoHorizontal:
                cmp ch, 0
                je finarbolitoHorizontal
                call putchar
                dec ch
            jmp arbolitoHorizontal
            
            finarbolitoHorizontal:

        dec cl
    jmp arbolitoVertical
    
    finArbolitoVertical:

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

