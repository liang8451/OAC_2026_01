%include "./pc_io.inc"
global _start

section .data

	; INSTRUCCION 1
	;Esto define una cadena de texto con salto de línea (0x0A) y una constante len que guarda la longitud del mensaje.

	msj: db 'Ingrese un dígito (0-9)',0x0  ; mensaje 
	len: equ $-msj	

section .bss

	;INSTRUCCION 2
	;Aquí se reserva un byte para almacenar el valor ingresado.

	num1 resb 1 
	num2 resb 1

section .text
_start:

	;INSTRUCCION 3

	;sys_write(stdout, message, length)
	;mov eax, 4 
	;mov ebx, 1 
	;mov ecx, msj 
	;mov edx, len 
	;int 80h 

	;mov eax, 3 
	;mov ebx, 0 
	;mov ecx, num1 
	;mov edx, 1 
	;int 80h 

	;sys_write(stdout, message, length)
	;mov eax, 4 
	;mov ebx, 1 
	;mov ecx, num1 
	;mov edx, 1 
	;int 80h 

	;INSTRUCCION 5

	;mov edx, msj
	;call puts
	;call getch
	;call putchar

	;INSTRUCCION 7

	;mov edx, msj 
	;call puts 
	;call salto 
	;call getch 
	;call salto 
	;call putchar 
	;call salto

	;INSTRUCCION 9

	;mov ebx, num1 
	;mov byte[ebx], al 
	;add byte[ebx], 1 
	;mov al, byte[ebx] 
	;call putchar 

	;INSTRUCCION 11
	
	mov edx, msj 
	call puts 
	call salto
	call getch
	mov [num1], al
	call putchar
	call salto

	call puts
	call salto
	call getch
	mov [num2], al
	call putchar
	call salto

	mov ebx, num1 
	mov al, [ebx] 
	mov ebx, num2 
	add [ebx], al 
	mov al, byte[ebx] 
	call putchar
	
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
