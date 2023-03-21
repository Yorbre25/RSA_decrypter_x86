%include "AsciiToDec.inc"

section .data
    ; num db 254
    ; exp dw 1631
    ; mod dw 5963
    mod db 50
    num db 3
    exp db 200
    array times 13 dw 0

section .bss
    ; array resb 13

section .text
    global _start

_start:
    mov rbx, 0          ;Index de array
    ; mov rax, [num]
    ; mov rdx, [mod]      ;Obtener modulo
    ; mov r10, [exp]      ;Obtener exponente
    mov rax, 254
    mov rdx, 5963      ;Obtener modulo
    mov r10, 1631      ;Obtener exponente

    mov [array], al  ;Guardar el numero para exponente 1 (NO SE VERIFICA SI EL NUMERO ES MENOR QUE EL MODULO)
    guardar1:
    shr r10, 1          ;Eliminar el bit menos significativo
    ;Crear tabla
    loop:
        add rbx, 4                ;Incrementar index (de 4 en 4 porque cada elemento del array son 4 bytes)
        mov rcx, [array + rbx - 4] ;Obtener el numero anterior
        imul rcx, rcx

        ;Obtener modulo (x mod(y))
        prefuncion:
        push rcx                ;Push x
        push rdx                ;Push y
        call modulo
        resultado:
        mov [array + rbx], rax        ;Guardar el resultado en la tabla
        shr r10, 1              ;Eliminar el bit menos significativo

        cmp r10, 0              ;Comprobar si el exponente es 0
        jne loop


final:
    ;Terminar programa
    mov rax, 1         
    mov ebx, 0   
    int 0x80           

; x mod(y)
modulo:
    push rbp ;Ocupa 8 bytes     ;Guardar el valor de ebp sirve como referencia
    mov rbp, rsp                ;Set el nuevo base pointer

    mov esi, [rbp + 16]         ;Obtener valor de y
    push1:
    mov eax, [rbp + 24]         ;obtener valor de x
    push2:

    cmp eax, esi                ;Comprobar si x es menor que y
    jl break_loop_resta

    loop_resta:
        sub eax, esi            ;Restar y a x
        cmp eax, esi            ;Comprobar si x es menor que y
        jge loop_resta

    break_loop_resta:
    mov [rbp - 8], eax          ;Valor de retorno

    mov rsp, rbp                ;Mover el stack pointer a la posición de rbp
    pop rbp                     ;Recuperar el valor de rbp
    ret                         ;Retornar