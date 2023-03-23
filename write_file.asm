writing_loop:
    print_data:
        mov r9, 7                      ;posicion del bit por impirmir
        mov r10, 8                     ;contador del print
        print:
            xor rax, rax
            mov cl, r9b                 ;Obtener el dato a imprimir
            mov rbx, [data]
            preshift:
            shr rbx, cl                 ;Desplazar el bit a imprimir
            shift:
            and rbx, 1                  ;Obtener el bit

            debug4:
            add rbx, 48                 ;Convertir a ASCII
            mov [digito_print], rbx     ;Guardar el digito a imprimir

            debug5:
            mov rax, 4                          ;sys_write
            mov rbx, [fd_out]                   ;File descriptor fd
            mov rcx, digito_print               ;Puntero al digito a imprimir
            mov rdx, 1                          ;Tamaño del buffer
            int 0x80                            ;Llamada al sistema

            dec r9
            dec r10

            cmp r10, 0
            jne print

write_space:
mov rax, 4                          ;sys_write
mov rbx, [fd_out]                   ;File descriptor fd
mov rcx, space                      ;Puntero al valor ASCII de espacio
mov rdx, 1                          ;Tamaño del buffer
int 0x80                            ;Llamada al sistema
    
jmp keep_reading

