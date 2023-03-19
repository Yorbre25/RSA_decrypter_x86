;.386
;.model flat,stdcall
;.stack 4096
;ExitProcess proto,dwExitCode:dword

section .data

    ;Mensajes para ingresas los valores de la llave
    ;privada
    inputE db "Introduzca e: "
    lenInputE equ $-inputE
    
    inputD db "Introduzca d: "
    lenInputD equ $-inputD

    inputN db "Introduzca n: "
    lenInputN equ $-inputN

section .bss
    e resb 3
    d resb 3
    n resb 3

section .text
    global _start
    
_start:
    ;Print Input de e
    mov eax, 4          ;System call "print"
    mov ebx, 1          ;NO c
    mov ecx, inputE     ;Mensaje
    mov edx, lenInputE  ;Tamaño de mensaje
    int 0x80

    ;Leer input
    mov eax, 3          ;System call "read"
    mov ebx, 2          ;No c
    mov ecx, e          ;Almacenar en e
    mov edx, 3          
    int 0x80


    ;Print Input de d
    mov eax, 4          ;System call "print"
    mov ebx, 1          ;NO c
    mov ecx, inputD     ;Mensaje
    mov edx, lenInputD  ;Tamaño de mensaje
    int 0x80

    ;Leer input
    mov eax, 3          ;System call "read"
    mov ebx, 2          ;No c
    mov ecx, d          ;Almacenar en d
    mov edx, 3          
    int 0x80


    ;Print Input de n
    mov eax, 4          ;System call "print"
    mov ebx, 1          ;NO c
    mov ecx, inputN     ;Mensaje
    mov edx, lenInputN  ;Tamaño de mensaje
    int 0x80

    ;Leer input
    mov eax, 3          ;System call "read"
    mov ebx, 2          ;No c
    mov ecx, n          ;Almacenar en n
    mov edx, 3          
    int 0x80

_final:
    ;Acabar
    mov eax, 1
    mov ebx, 0
    int 0x80
