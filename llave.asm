%include "Constantes.inc"
%include "AsciiToDec.inc"

section .data

section .bss
    e resb inputSize
    d resb 4
    n resb 4

section .text
    global _start
    
_start:
    ;Print Input de e
    mov eax, 4              ;System call "print"
    mov ebx, 1              ;File descriptor (stdout)
    mov ecx, inputE         ;Mensaje
    mov edx, lenInputE      ;Tamaño de mensaje
    int 0x80

    ;Leer input
    mov rax, 3              ;System call "read"
    mov rbx, 2              ;No c
    mov rcx, e              ;Almacenar en e
    mov rdx, inputSize      ;Número de bytes a leer
    int 0x80

    push inputSize ;(Ocupa 2 bytes)                 ;Tamaño de e al stack
    push e ;(Ocupa 8 bytes)                         ;Pasar direccion de e al stack
    call ascii_to_dec ;(Ocupa 2 bytes)              ;Llamar a ascii_to_dec

    mov [e], eax            ;Guardar el valor en e


_final:
    ;Acabar
    mov eax, 1
    mov ebx, 0
    int 0x80

