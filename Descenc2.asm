%include "ascii_dec.inc"
%include "modulo.asm"

section .data
    ; num db 254
    ; exp dw 1631
    ; mod dw 5963
    mod db 50
    num db 3
    exp db 200

section .bss

section .text
    global _start

_start:
    ; mov r8, [base]      ;Obtener mensaje encriptado
    ; mov r9, [mod]      ;Obtener modulo
    ; mov r10, [exp]      ;Obtener exponente
    mov r8,254              ;base
    mov r9,7031               ;mod
    mov r10,6449               ;exp

    mov rbx, 1              ;Inicializar resultado en 1
    squareAndMul:
        cmp r10, 0          ;Comprobar si el exponente ya no tiene bits 1
        je break_squareAndMul
        mov rcx, r10
        and rcx, 1          ;Obtener el bit menos significativo

        cmp rcx, 1          ;Comprobar si el bit es 1
        jne squaring

        multiply:
            push rbx        ;Guardar en stack el valor del resultado (b)
            push r8         ;Guardar en stack el valor del mensaje encriptado (a)
            push r9         ;Guardar en stack el valor del modulo (y)
            call modMul     ;a*b mod(y)

            mov rbx, rax    ;Guardar resultado de la operacion
        squaring:
            push r8         ;Guardar en stack el valor del mensaje encriptado (b)
            push r8         ;Guardar en stack el valor del mensaje encriptado (a)
            push r9         ;Guardar en stack el valor del modulo (n)
            call modMul     ;a*b mod(y)

            mov r8, rax    ;Guardar resultado en la base
        shr r10, 1          ;Mover el exponente un bit a la derecha
        jnz squareAndMul
    break_squareAndMul:


final:
    ;Terminar programa
    mov rax, 1         
    mov ebx, 0   
    int 0x80           

