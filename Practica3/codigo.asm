%include "./pc_io.inc"
  global _start

section .data
  msj1: db 'Ingrese un numero (0-9)',0x0
  len1: equ $-msj1


section .bss
    num1: resb 1
    num2: resb 2
    cadena: resb 2

section .text
  _start:

  ;COPIA msj1 A edx Y LO MUESTRA
  mov edx, msj1
  call puts
  call salto

  ;PIDE UN CARACTER Y LO GUARDA A num1
  call getch
	mov ebx, num1
	mov [ebx], al
	call putchar
  call salto
  
  ;LO MUESTRA msj1 EN edx
  call puts
  call salto

  ;PIDE UN CARACTER Y LO GUARDA A num2
  call getch
	mov ebx, num2
	mov [ebx], al
	call putchar
  call salto

  ;MUESTRA EL num1
  mov ebx, num1
	mov al, [ebx]
	call putchar

  ;MUESTRA x
  mov al, 'x'
	call putchar

  ;MUESTRA EL num2
  mov ebx, num2
	mov al, [ebx]
	call putchar

  ;MUESTRA x
  mov al, '='
	call putchar

  ;CONVIERTE num1 DE CARACTER A NUMERO
  mov ebx, num1
	sub byte[ebx], '0'

  ;CONVIERTE num2 DE CARACTER A NUMERO
	mov ebx, num2
	sub byte[ebx], '0'

  ;MULTIPLICACION
  mov cl, 1 ;CONTADOR
  mov ebx, num2 ;MUEVE num2 A ebx
  mov al, byte[ebx] ;al TIENE num2
  mov edx, num1 ;MUEVE num1 A edx

  sumar:
    cmp cl , byte[edx]
    je finsumar
    add al, byte[ebx]
    inc cl
    jmp sumar
    
  finsumar:
    mov esi, cadena
    call printHex


  ;MUESTRA msj1 EN edx
  call puts
  call salto

  ;PIDE UN CARACTER Y LO GUARDA A num1
  call getch
	mov ebx, num1
	mov [ebx], al
	call putchar
  call salto
  
  ;MUESTRA msj1 EN edx
  call puts
  call salto

  ;PIDE UN CARACTER Y LO GUARDA A num2
  call getch
	mov ebx, num2
	mov [ebx], al
	call putchar
  call salto

  ;MUESTRA EL num1
  mov ebx, num1
	mov al, [ebx]
	call putchar

  ;MUESTRA x
  mov al, '/'
	call putchar

  ;MUESTRA EL num2
  mov ebx, num2
	mov al, [ebx]
	call putchar

  ;MUESTRA x
  mov al, '='
	call putchar

  ;CONVIERTE num1 DE CARACTER A NUMERO
  mov ebx, num1
	sub byte[ebx], '0'

  ;CONVIERTE num2 DE CARACTER A NUMERO
	mov ebx, num2
	sub byte[ebx], '0'

  ;DIVISION
  mov cl, 1 ;CONTADOR
  mov ebx, num2 ;MUEVE num2 A ebx
  mov al, byte[ebx] ;al TIENE num2
  mov edx, num1 ;MUEVE num1 A edx

  mov ecx, 4
  .rep:
  sub edx, ebx
  cmp edx, 0
  je finrestar
  inc cl
  loop .rep

  finrestar:
  mov esi, cadena
  mov al, cl
  call printHex
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
