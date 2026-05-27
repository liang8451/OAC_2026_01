global ordenarArreglo

section .text

ordenarArreglo:
  push ebp
  mov ebp, esp

  push eax
  push ebx
  push ecx
  push esi

  mov ebx,[ebp+8]
  mov ecx,[ebp+12]

  dec ecx
  jz .salir

  .ordenar:
    mov eax, [ebx]
    mov esi, 1
    push ecx
    .buscarMenor:
      cmp eax, [ebx+esi*4]
      jl .menor
        xchg eax, [ebx+esi*4]
      .menor:
        inc esi
    loop .buscarMenor
    pop ecx
    mov [ebx], eax
    add ebx, 4
  loop .ordenar

  .salir:
  pop esi
  pop ecx
  pop ebx
  pop eax
  pop ebp
ret
