%include "./pc_io.inc"

global _start

section .data
  cadena: db 'calvito calvoa calvocalvo calvo  calv o%'
  palabra: db 'calvo%'
    
section .bss
  hex: resb 10

section .text

_start:

mov edx, cadena
mov edi, palabra
call buscarPalabra

mov esi, hex
call printHex
call salto

mov eax, 1
mov ebx, 0
int 80h

buscarPalabra:
	mov cl, 0
	mov esi, 0
	.longitud:
		cmp byte[edi+esi], '%'
		je .salirLongitud
		inc esi
	jmp .longitud
	.salirLongitud:
	mov ebp, esi
	mov esi, 0
	.recorrido:
		cmp byte[edx+esi], '%'
		je .salirRecorrido
		mov al, [edi]
		cmp byte[edx+esi], al
		jne .continue
			lea ebx, [edx+esi]
			push esi
			mov esi, 0
			push ebp
			mov ah, 1
			.comparar:
				cmp ah, 0
				je .salirComparar
				cmp ebp, 0
				je .salirComparar
				mov al, [edi+esi]
				cmp byte[ebx+esi], al
				je .iguales
					mov ah, 0
				.iguales:
				dec ebp
				inc esi
			jmp .comparar
			.salirComparar:
			add cl, ah
			pop ebp
			pop esi
		.continue:
		inc esi
	jmp .recorrido
	.salirRecorrido:
	movzx eax, cl
ret



printHex:
  ;EAX = EL VALOR A MOSTRAR
  ;ESI = UN ESPACIO DE 10 BITS
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

printBin:
  ;AL = VALOR A MOSTRAR
  
    pushad
    mov ecx, 8
    mov bl, al

    .rotacion:
      rcl bl, 1

      jc .uno
      mov al, '0'
      call putchar
      jmp .continue
      .uno: 
      mov al, '1'
      call putchar
      .continue:
    loop .rotacion

popad
ret


salto:
push ax
mov al, 13
call putchar
mov al, 10
call putchar
pop ax
