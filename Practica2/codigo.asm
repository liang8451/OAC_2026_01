%include "./pc_io.inc"
global _start

section .data

	; INSTRUCCION 1
	;Esto define una cadena de texto con salto de línea (0x0A) y una constante len que guarda la longitud del mensaje.

	msj: db 'Ingrese un dígito (0-9)',0x0A  ; mensaje y nueva linea
	len: equ $-msj	

section .bss

	;INSTRUCCION 2
	;Aquí se reserva un byte para almacenar el valor ingresado.

	num1 resb 1 

section .text
_start:

	;INSTRUCCION 3

	;sys_write(stdout, message, length)
	mov eax, 4 
	mov ebx, 1 
	mov ecx, msj 
	mov edx, len 
	int 80h 

	mov eax, 3 
	mov ebx, 0 
	mov ecx, num1 
	mov edx, 1 
	int 80h 

	;sys_write(stdout, message, length)
	mov eax, 4 
	mov ebx, 1 
	mov ecx, num1 
	mov edx, 1 
	int 80h 

	mov eax 1
	mov ebx 0
	int 80h

	;INSTRUCCION 4

						



