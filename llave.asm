%include "Constantes.inc"
%include "ascii_dec.inc"
    
get_inputs:
    ;Write Input de n
    mov eax, 4              ;System call "write"
    mov ebx, 1              ;File descriptor (stdout)
    mov ecx, inputN         ;Mensaje
    mov edx, lenInputN      ;Tamaño de mensaje
    int 0x80

    ;Leer input
    mov rax, 3              ;System call "read"
    mov rbx, 2              ;No c
    mov rcx, n              ;Almacenar en n
    mov rdx, 5      ;Número de bytes a leer
    int 0x80
    lectura1:
    ; Write Input de d
    mov eax, 4              ;System call "write"
    mov ebx, 1              ;File descriptor (stdout)
    mov ecx, inputD         ;Mensaje
    mov edx, lenInputD      ;Tamaño de mensaje
    int 0x80

    ;Leer input
    mov rax, 3              ;System call "read"
    mov rbx, 2              ;No c
    mov rcx, d              ;Almacenar en d
    mov rdx, 5      ;Número de bytes a leer
    int 0x80

    push inputSize ;(Ocupa 2 bytes)                 ;Tamaño de n al stack
    push n ;(Ocupa 8 bytes)                         ;Pasar direccion de n al stack
    call ascii_to_dec ;(Ocupa 2 bytes)              ;Llamar a ascii_to_dec

    mov [n], eax            ;Guardar el valor en e
    
    push inputSize ;(Ocupa 2 bytes)                 ;Tamaño de e al stack
    push d ;(Ocupa 8 bytes)                         ;Pasar direccion de e al stack
    call ascii_to_dec ;(Ocupa 2 bytes)              ;Llamar a ascii_to_dec

    mov [d], eax            ;Guardar el valor en d
 
jmp post_inputs

