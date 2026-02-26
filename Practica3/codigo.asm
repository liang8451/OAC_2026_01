%include "./pc_io.inc"
  global _start

section .data
  msj1: db 'Ingrese un numero (1-9)',0x0
  len1: equ $-msj1


section .bss
    num1: resb 2
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
  mov ebx, num1
  mov ecx, [ebx] ;CONTADOR DEL LOOP, EMPIEZA CON num1
  mov al, 0 ;al GUARDA LA SUMA
  mov ebx, num2

  sumar:
    add al, byte[ebx]
  loop sumar

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

  ;MUESTRA =
  mov al, '='
	call putchar

  ;CONVIERTE num1 DE CARACTER A NUMERO
  mov ebx, num1
	sub byte[ebx], '0'

  ;CONVIERTE num2 DE CARACTER A NUMERO
	mov ebx, num2
	sub byte[ebx], '0'

  ;DIVISION
  mov cl, 0 ;cl GUARDA LAS VECES QUE SE RESTA
  mov ebx, num1
  mov eax, [ebx] ;eax GUARDA num1
  mov ebx, num2
  mov ebx, [ebx] ;ebx GUARDA num2
  cmp ebx, 0
  je salirRestar
  

  restar:
  cmp eax, 0
  je salirRestar
  sub eax, ebx
  inc cl
  jmp restar
  
  salirRestar:
  mov al, cl
  mov esi, cadena
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
