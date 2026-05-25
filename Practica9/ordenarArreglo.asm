%include "./pc_io.inc"

global _start

section .data
    msj1: db 'Ingresar tam del arreglo: ', 0x0
    msj2: db 'Ingresar valor decimal de 3 digitos: ', 0x0
section .bss
  arreglo: resw 9

section .text

_start:
  mov ebx, arreglo
  call capturarArreglo
  call imprimirArreglo
  call ordenarArreglo
  call imprimirArreglo

  mov eax, 1
  mov ebx, 0
  int 80h

printDecimal:
  ;AX RECIBE EL VALOR A IMPRIMIR EN DECIMAL
  push ax
  push bx
  push cx
  push dx

  mov bx, 10
  xor cx, cx
  xor dx, dx

  cmp ax, 0
  jne .convertir
  mov al, '0'
  call putchar
  jmp .salirImprimir

  .convertir:
    cmp ax, 0
    je .salirConvertir
    xor dx,dx
    div bx
    push dx 
    inc cx
  jmp .convertir
  .salirConvertir:

  .imprimir:
    cmp cx, 0
    je .salirImprimir

    pop ax
    add ax, '0'
    call putchar
    dec cx
  jmp .imprimir
  .salirImprimir:
  
  pop dx
  pop cx
  pop bx
  pop ax
ret

capturarDecimal:
  ;AX DEVUELVE EL VALOR DE 3 DIGITOS
  push dx
  xor dx, dx
  
  call getche
  sub al, '0'
  mov ah, 100
  mul ah
  add dx, ax
  
  call getche
  sub al, '0'
  mov ah, 10
  mul ah
  add dx, ax
 
  call getche
  sub al, '0'
  add dx, ax
  
  mov ax, dx
  pop dx
  call salto
ret

capturarDecimalNuevo:
  ;AX DEVUELVE EL VALOR DE n DIGITOS
  push bx
  push cx
  push dx


  xor ax, ax
  xor bx, bx
  xor cx, cx
  xor dx, dx

  .capturar:
    call getche
    
    cmp al, '.'
    je .salirCapturar

    sub al, '0'
    movzx ax, al
    push ax
    inc cx

  jmp .capturar
  .salirCapturar:
  
  xor ax,ax
  cmp cx, 0
  je .saltarSumar

  pop dx
  dec cx

  cmp cx, 0
  je .saltarSumar

  .sumar:
    inc bx
    pop ax

    push cx
    push dx
    mov cx, bx
    .potencia:
      mov dx, 10
      mul dx
    loop .potencia

    pop dx
    pop cx
    
    add dx, ax
  loop .sumar
  .saltarSumar:
  mov ax, dx
  pop dx
  pop cx
  pop bx
  call salto
ret


capturarArreglo:
  ;EBX RECIBE LA DIRECCION DEL arreglo
  ;CX DEVUELVE EL TAMAÑO DEL ARREGLO
  push edx
  push esi 
  xor cx, cx
  xor esi, esi

  mov edx, msj1
  call puts
  call getche 
  sub al, '0'
  movzx cx, al
  push cx
  call salto

  cmp cx, 0
  je .salir 

  mov edx, msj2
  .capturar:
    call puts 
    call capturarDecimalNuevo
    mov [ebx+esi*2], ax
    inc esi 
  loop .capturar

  .salir:
  pop cx
  pop esi 
  pop edx
ret

imprimirArreglo:
  ;EBX RECIBE LA DIRECCION DEL arreglo
  ;CX RECIBE EL TAMAÑO DEL arreglo

  push esi
  push ax 
  push cx

  xor esi,esi 
  cmp cx, 0
  je .salir

  .imprimir:
    mov ax, [ebx+esi*2]
    call printDecimal
    inc esi
    cmp cx, 1
    je .final
    mov al, ','
    call putchar
    .final:
  loop .imprimir
  call salto
  .salir:
  pop cx
  pop ax
  pop esi
ret

ordenarArreglo:
  ;EBX RECIBE LA DIRECCION DEL arreglo
  ;CX RECIBE EL TAMAÑO DEL arreglo
  push ebx
  push cx
  
  cmp cx, 0
  je .salir
  dec cx
  cmp cx, 0
  je .salir

  movzx ecx, cx
  .recorrido:
    mov ax, [ebx]
    push ecx
    .comparar:
      cmp ax, [ebx+ecx*2]
      jb .mayor
      xchg ax, [ebx+ecx*2]
      .mayor:
    loop .comparar
    mov [ebx], ax
    add ebx, 2
    pop ecx
  loop .recorrido
  
  .salir:
  pop cx
  pop ebx
ret


salto:
  push ax 
  mov al, 13
  call putchar
  mov al, 10
  call putchar
  pop ax
ret
