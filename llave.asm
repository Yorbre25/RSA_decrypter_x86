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
    mov eax, 4              ;System call "print"
    mov ebx, 1              ;File descriptor (stdout)
    mov ecx, inputE         ;Mensaje
    mov edx, lenInputE      ;Tamaño de mensaje
    int 0x80

    ;Leer input
    mov rax, 3              ;System call "read"
    mov rbx, 2              ;No c
    mov rcx, e              ;Almacenar en e
    mov rdx, 4          
    int 0x80

    prepush:
    push $4 ;(Ocupa 2 bytes)                 ;Tamaño de e (falta la variable) al stack
    push1:
    push e ;(Ocupa 8 bytes)               ;Pasar direccion de e al stack
    pusheo:
    call funcion ;(Ocupa 2 )           ;Llamar a funcion

    mov [e], eax            ;Guardar el valor en e

    ; NO PUEDO LEER MAS DE UN VALOR
    ;Print Input de d
    ; mov eax, 4              ;System call "print"
    ; mov ebx, 1              ;File descriptor (stdout)
    ; mov ecx, inputD         ;Mensaje
    ; mov edx, lenInputD      ;Tamaño de mensaje
    ; int 0x80

    ; ;Leer input
    ; mov eax, 3              ;System call "read"
    ; mov ebx, 2              ;No c
    ; mov ecx, d              ;Almacenar en e
    ; mov edx, 4          
    ; int 0x80

    ; push $4
    ; push d
    ; call funcion


   

_final:
    ;Acabar
    mov eax, 1
    mov ebx, 0
    int 0x80

;Funcion para convertir ascii a decimal
;Entrada:
;    param0: número de dígitos en decimal (tamaño)
;    param1: dirección de la cadena de caracteres
funcion:
    push rbp ;Ocupa 8 bytes      ;Guardar el valor de ebp sirve como referencia
    pushenf:
    mov rbp, rsp                ;Set el nuevo base pointer
    nose:

    mov esi, [rbp + 16]         ;Puntero a cadena de caracteres
    mov ebx, esi        
    mov ecx, [rbp + 24]         ;Tamaño de cadena de caracteres
    add ebx, ecx                ;Dirección final de cadena de caracteres
    xor eax, eax                ;Inicializar eax

    ascii_to_dec:
        movzx edx, byte [esi]   ;Cargar primer byte de cadena de caracteres

        sub edx, 48             ;Restar 48 para obtener el valor

        imul eax, 10            ;Tomar el valor actual y multiplicarlo por 10
        add eax, edx            ;Sumar el valor actual con el nuevo dígito

        inc esi                 ;Incrementar puntero

        cmp esi, ebx            ;Comparar puntero con el final de cadena de caracteres
        jne ascii_to_dec        ;Si no es igual, saltar a ascii_to_dec

    mov [rbp - 8], eax          ;Valor de retorno

    mov rsp, rbp                ;Mover el stack pointer a la posición de rbp
    pop rbp                     ;Recuperar el valor de rbp
    ret                         ;Retornar

    

