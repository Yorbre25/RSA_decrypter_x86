%include "Constantes.inc"
%include "AsciiToDec.inc"

section .data

    ;Mensajes para ingresas los valores de la llave
    ;privada
    ; inputE db "Introduzca e: "
    ; lenInputE equ $-inputE
    
    ; inputD db "Introduzca d: "
    ; lenInputD equ $-inputD

    ; inputN db "Introduzca n: "
    ; lenInputN equ $-inputN

    ; inputSize equ 4
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

    prepush:
    push inputSize ;(Ocupa 2 bytes)                 ;Tamaño de e al stack
    push1:
    push e ;(Ocupa 8 bytes)                         ;Pasar direccion de e al stack
    pusheo:
    call ascii_to_dec ;(Ocupa 2 bytes)              ;Llamar a ascii_to_dec

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
    ; call ascii_to_dec

_final:
    ;Acabar
    mov eax, 1
    mov ebx, 0
    int 0x80

; ;Funcion para convertir ascii a decimal. Si el char es un espacio o null
; ;se ignora.
; ;Entrada:
; ;    param0: número de caracteres (tamaño)
; ;    param1: dirección en memoria de la cadena de caracteres
; ascii_to_dec:
;     push rbp ;Ocupa 8 bytes      ;Guardar el valor de ebp sirve como referencia
;     pushenf:
;     mov rbp, rsp                ;Set el nuevo base pointer
;     nose:

;     mov esi, [rbp + 16]         ;Puntero a cadena de caracteres
;     mov ebx, esi        
;     mov ecx, [rbp + 24]         ;Tamaño de cadena de caracteres
;     add ebx, ecx                ;Dirección final de cadena de caracteres
;     xor eax, eax                ;Inicializar eax

;     nextByte:
;         movzx edx, byte [esi]   ;Cargar primer byte de cadena de caracteres

;         cmp edx, 32             ;Checkear si el codigo ascii es un espacio " "
;         je continueNextByte     ;Si el char es un espacio, saltarse la conversión a decimal
;         cmp edx, 10             ;Checkear si el codigo ascii es vacio ""
;         je break_nextByte       ;Si el char es null, salir de la función

;         sub edx, 48             ;Restar 48 para obtener el valor

;         imul eax, 10            ;Tomar el valor actual y multiplicarlo por 10
;         add eax, edx            ;Sumar el valor actual con el nuevo dígito

;         continueNextByte:
;         inc esi                 ;Incrementar puntero

;         cmp esi, ebx            ;Comparar puntero con el final de cadena de caracteres
;         jne nextByte            ;Si no es igual, saltar a nextByte
;     break_nextByte:
;     mov [rbp - 8], eax          ;Valor de retorno

;     mov rsp, rbp                ;Mover el stack pointer a la posición de rbp
;     pop rbp                     ;Recuperar el valor de rbp
;     ret                         ;Retornar

    

