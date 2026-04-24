%include "./pc_io.inc"

global _start

section .data
    cad: db '0110111100011000'
    cad2: db '12345'
    
section .bss
    hex: resb 10 

section .text

_start:
mov eax, 0

mov edx, cad
call cadBintoHex

mov esi, hex
call printHex
call salto


mov eax, 0

mov edx, cad2
call cadDectoHex

mov esi, hex
call printHex
call salto

mov eax, 1
mov ebx, 0
int 80h

cadBintoHex:
    push esi
    push ecx
    push bx

    mov esi, 0
    mov ecx, 16

    .recorrido:
    cmp byte[edx+esi],'0'
    je .cero
    cmp byte[edx+esi], '1'
    je .uno

    .cero:
        sal ax, 1
        jmp .continue
    
    .uno:
        mov bl, 0xFF
        add bl, bl
        rcl ax, 1
    
    .continue:
    inc esi

    loop .recorrido

    pop bx
    pop ecx
    pop esi

    ret

cadDectoHex:
  mov ebp, edx
  mov ax, 0
  mov bx, 0
  mov ecx, 5
  mov dx, 0
  mov esi, 0

  .recorrido:
    mov ax, 0
    mov al, [ebp+ecx-1]
    sub al, '0'

    cmp esi, 0
    je .sumar

    push ecx
    mov ecx, esi

    .multiplicar:
      mov dx, 10
      mul dx
    loop .multiplicar

    pop ecx
    
    .sumar:
      add bx, ax

    inc esi

  loop .recorrido

mov ax, bx
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

salto:
push ax
mov al, 13
call putchar
mov al, 10
call putchar
pop ax
