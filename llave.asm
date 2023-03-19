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
    e resb 4
    d resb 4
    n resb 4

section .text
    global _start
    
_start:
    ;Print Input de e
    mov eax, 4          ;System call "print"
    mov ebx, 1          ;File descriptor (stdout)
    mov ecx, inputE     ;Mensaje
    mov edx, lenInputE  ;Tamaño de mensaje
    int 0x80

    ;Leer input
    mov eax, 3          ;System call "read"
    mov ebx, 2          ;No c
    mov ecx, e          ;Almacenar en e
    mov edx, 4          
    int 0x80

    ; Convertir de ascii a int
    mov esi, e          ;Puntero a e
    mov ebx, esi
    add ebx, 4          ;Tamaño de e (viene una variable)
    mov eax, 0          ;Inicializar eax

ascii_to_int:
    movzx edx, byte [esi]   ;Cargar primer byte de e

    sub edx, 48             ;Restar 48 para obtener el valor

    imul eax, 10        ;Tomar el valor actual y multiplicarlo por 10
    add eax, edx        ;Sumar el valor actual con el nuevo dígito

    inc esi             ;Incrementar puntero

    cmp esi, ebx        ;Comparar puntero con el final de e
    jne ascii_to_int    ;Si no es igual, saltar a ascii_to_int

    mov [e], eax        ;Guardar el valor en e




    ;push [e]
    ;jmp ascii_to_int

    ; ;Print Input de d
    ; mov eax, 4          ;System call "print"
    ; mov ebx, 1          ;File descriptor (stdout)
    ; mov ecx, inputD     ;Mensaje
    ; mov edx, lenInputD  ;Tamaño de mensaje
    ; int 0x80

    ; ;Leer input
    ; mov eax, 3          ;System call "read"
    ; mov ebx, 2          ;No c
    ; mov ecx, d          ;Almacenar en d
    ; mov edx, 4          
    ; int 0x80


    ; ;Print Input de n
    ; mov eax, 4          ;System call "print"
    ; mov ebx, 1          ;File descriptor (stdout)
    ; mov ecx, inputN     ;Mensaje
    ; mov edx, lenInputN  ;Tamaño de mensaje
    ; int 0x80

    ; ;Leer input
    ; mov eax, 3          ;System call "read"
    ; mov ebx, 2          ;No c
    ; mov ecx, n          ;Almacenar en n
    ; mov edx, 4          
    ; int 0x80

_final:
    ;Acabar
    mov eax, 1
    mov ebx, 0
    int 0x80


