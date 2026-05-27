
section .text
global _start

_start:

  call getche

  mov eax, 1
  mov ebx, 0
  int 80h

getche:
    push ebx
    push ecx
    push edx

    dec esp
    
    mov eax, 3          
    mov ebx, 0          
    mov ecx, esp        
    mov edx, 1          
    int 80h

    xor eax, eax
    mov al, [esp]       
   
   inc esp
    
    pop edx
    pop ecx
    pop ebx
ret
