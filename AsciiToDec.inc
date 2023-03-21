;Funcion para convertir ascii a decimal. Si el char es un espacio o null
;se ignora.
;Entrada:
;    param0: número de caracteres (tamaño)
;    param1: dirección en memoria de la cadena de caracteres
;Salida:
;    eax: valor decimal
ascii_to_dec:
    push rbp ;Ocupa 8 bytes      ;Guardar el valor de ebp sirve como referencia
    mov rbp, rsp                ;Set el nuevo base pointer
    nose:

    mov esi, [rbp + 16]         ;Puntero a cadena de caracteres
    mov ebx, esi        
    mov ecx, [rbp + 24]         ;Tamaño de cadena de caracteres
    add ebx, ecx                ;Dirección final de cadena de caracteres
    xor eax, eax                ;Inicializar eax

    nextByte:
        movzx edx, byte [esi]   ;Cargar primer byte de cadena de caracteres

        cmp edx, 32             ;Checkear si el codigo ascii es un espacio " "
        je continueNextByte     ;Si el char es un espacio, saltarse la conversión a decimal
        cmp edx, 10             ;Checkear si el codigo ascii es vacio ""
        je break_nextByte       ;Si el char es null, salir de la función

        sub edx, 48             ;Restar 48 para obtener el valor

        imul eax, 10            ;Tomar el valor actual y multiplicarlo por 10
        add eax, edx            ;Sumar el valor actual con el nuevo dígito

        continueNextByte:
        inc esi                 ;Incrementar puntero

        cmp esi, ebx            ;Comparar puntero con el final de cadena de caracteres
        jne nextByte            ;Si no es igual, saltar a nextByte
    break_nextByte:
    mov [rbp - 8], eax          ;Valor de retorno

    mov rsp, rbp                ;Mover el stack pointer a la posición de rbp
    pop rbp                     ;Recuperar el valor de rbp
    ret                         ;Retornar