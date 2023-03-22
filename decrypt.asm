%include "modulo.asm"

modular_exponentiation:
    push rbp ;Ocupa 8 bytes     ;Guardar el valor de ebp sirve como referencia
    mov rbp, rsp                ;Set el nuevo base pointer

    mov r8, [rbp + 16]         ;Obtener valor de la base

    movzx r9, word [n]               ;mod
    movzx r10, word [d]               ;exp
    ; mov r9,15               ;mod
    ; mov r10,11               ;exp

    mov rbx, 1              ;Inicializar resultado en 1
    square_and_mul:
        cmp r10, 0          ;Comprobar si el exponente ya no tiene bits 1
        je break_square_and_mul
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
        jnz square_and_mul
    break_square_and_mul:

    mov [rbp - 8], rbx          ;Valor de retorno
    mov rax, rbx

    mov rsp, rbp                ;Mover el stack pointer a la posición de rbp
    pop rbp                     ;Recuperar el valor de rbp
    ret                         ;Retornar

