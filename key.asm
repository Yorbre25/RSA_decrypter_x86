%include "const.inc"
%include "ascii_dec.inc"

; Programa que extrae los valores de n y d de la consola

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
    mov rdx, inputSize      ;Número de bytes a leer
    int 0x80

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
    mov rdx, inputSize      ;Número de bytes a leer
    int 0x80

    push 4                                          ;Tamaño de n al stack
    push n                                          ;Pasar direccion de n al stack
    call ascii_to_dec                               ;Llamar a ascii_to_dec

    mov [n], eax                                    ;Guardar el valor en e
    
    push 4                                          ;Tamaño de e al stack
    push d                                          ;Pasar direccion de e al stack
    call ascii_to_dec                               ;Llamar a ascii_to_dec

    mov [d], eax                                    ;Guardar el valor en d
 
jmp post_inputs

