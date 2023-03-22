read_file:
    ;Abrir Archivo
    mov rax, 5                              ;sys_open
    mov rbx, inputFilename                  ;Nombre del archivo que se va a leer
    mov rcx, 0                              ;Flags
    mov rdx, 0777                           ;Permisos
    int 0x80                                ;Llamada al sistema

    ;NO SE VERIFICAN ERRORES
    mov [fd_in], eax                        ;Guardar file descriptor

    mov r15, 10                         
    reading_loop:
        ;Verificar si se llegó al final del archivo
        mov cl, byte [file_end]
        cmp cl, 1
        checkEnd:
        je break_reading_loop

        num1_loop:
            ;Leer un byte del archivo
            mov rax, 3                          ;sys_read
            mov rbx, [fd_in]                    ;File descriptor fd_in
            mov rcx, buffer                     ;Buffer
            mov rdx, 1                          ;Tamaño del buffer
            int 0x80                            ;Llamada al sistema

            ;Verificar si el valor es " ". Si lo es, romber el ciclo
            xor rax, rax
            mov al, byte [buffer]
            debug1:
            cmp rax, 32                         ;Checkear si el valor leido es un espacio
            je break_num1_loop                    
            cmp rax, 10                         ;Checkear si el valor leido es un salto de linea
            je set_file_end                 
 
            xor rbx, rbx                        ;Limpiar rbx    
            xor rax, rax                        ;Limpiar rax

            mov bl, byte [buffer]               ;Tomar valor leido
            sub rbx, 48                         ;Pasarlo a decimal
            nose1:
            ;Agregar el digito leido a num1
            mov rax, [num1]
            mul r15                             ;Multiplicar por 10 num1
            add rax, rbx                        ;Sumar el valor leido
            mov [num1], rax                     ;Guardar resultado

            jmp num1_loop
        break_num1_loop:

    ;Hacer shift left a num1
    mov rbx, [num1]                             ;Tomar numero leido
    shl rbx, 8                                  ;Hacerle un shift left de 8
    mov [num1], rbx                             ;Guardar resultado

        num2_loop:
            ;Leer un byte del archivo
            mov rax, 3                          ;sys_read
            mov rbx, [fd_in]                    ;File descriptor fd_in
            mov rcx, buffer                     ;Buffer
            mov rdx, 1                          ;Tamaño del buffer
            int 0x80                            ;Llamada al sistema

            ;Verificar si el valor es " ". 
            ;Si lo es, romber el ciclo
            xor rax, rax
            mov al, byte [buffer]
            debug2:
            cmp rax, 32                         ;Checkear si el valor leido es un espacio
            je break_num2_loop   
            cmp rax, 10                         ;Checkear si el valor leido es un salto de linea
            je set_file_end                 
 
            
            xor rbx, rbx                        ;Limpiar rbx
            xor rax, rax                        ;Limpiar rax

            mov bl, byte [buffer]               ;Tomar valor leido
            sub rbx, 48                         ;Pasarlo a decimal
            nose2:
            ;Agregar el digito leido a num2
            mov rax, [num2]
            mul r15                             ;Multiplicar por 10
            add rax, rbx                        ;Sumar el valor leido
            mov [num2], rax                     ;Guardar resultado

            jmp num2_loop   
        break_num2_loop:

        ;Sumar num1 y num2
        movzx rax, word [num1]
        movzx rbx, word [num2]
        xor [num1], rax                         ;Limpiar num1
        xor [num2], rbx                         ;Limpiar num2
        debug3:
        add eax, ebx                            ;Sumar num1 y num2

        ;Ir a descentrpaticion
        jmp decrypt  

    break_reading_loop:


    ;Cerrar archivo
    mov eax, 6
    mov ebx, [fd_in]
    int  0x80

    jmp end_program


; Marca que se llegó al final del archivo
set_file_end:
    mov byte [file_end], 1
    jmp break_num2_loop