section .text

global _start

_start:
  mov al, 'a'
  call putchar

  mov eax, 1
  mov ebx, 0
  int 80h

putchar:
  push ebp
  mov ebp, esp
  
  push eax
  push ebx
  push ecx
  push edx

  dec esp
  
  mov [esp], al

  mov eax, 4
  mov ebx, 1
  mov ecx, esp
  mov edx, 1
  int 80h

  inc esp

  pop edx
  pop ecx
  pop ebx
  pop eax
  pop ebp

ret
  
