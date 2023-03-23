;Función que calcula a*b mod(y)
; Entrada:
;   param0: b (int)
;   param1: a (int)
;   param2: y (int)
; Salida:
;   eax: a*b mod(y) (int)
modMul:
    push rbp ;Ocupa 8 bytes     ;Guardar el valor de ebp sirve como referencia
    mov rbp, rsp                ;Set el nuevo base pointer

    mov esi, [rbp + 16]         ;Obtener valor de y
    push1:
    mov eax, [rbp + 24]         ;obtener valor de a
    mov ecx, [rbp + 32]         ;obtener valor de b
    push2:
    imul eax, ecx               ;Multiplicar a*b

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

; Función que calcula el modulo a mod(y)
; Entrada:
;   param0: a (int)
;   param1: y (int)
; Salida:
;   eax: a mod(y) (int)
mod:
    push rbp ;Ocupa 8 bytes     ;Guardar el valor de ebp sirve como referencia
    mov rbp, rsp                ;Set el nuevo base pointer

    mov esi, [rbp + 16]         ;Obtener valor de y
    mov eax, [rbp + 24]         ;obtener valor de a

    cmp eax, esi                ;Comprobar si x es menor que y
    jl break_loop_mod

    loop_mod:
        sub eax, esi            ;Restar y a x
        cmp eax, esi            ;Comprobar si x es menor que y
        jge loop_mod

    break_loop_mod:
    mov [rbp - 8], eax          ;Valor de retorno

    mov rsp, rbp                ;Mover el stack pointer a la posición de rbp
    pop rbp                     ;Recuperar el valor de rbp
    ret                         ;Retornar