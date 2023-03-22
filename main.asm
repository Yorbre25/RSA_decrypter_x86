%include "readFile.asm"
%include "decrypt.asm"
%include "write_file.asm"

section .data
    inputFilename dw "5.txt", 0         ;Nombre del archivo que se va a leer
    outputFilename dw "output.txt"        ;Nombre del archivo que se va a escribir
    space dw 32
    n dw 5963
    d dw 1631

section .bss
    fd_in resb 4                        ;File descriptor
    fd_out resb 4                        ;File descriptor
    buffer resb 4                       ;Buffer de lectura
    num1 resb 4                         ;Primer numero leido
    num2 resb 4                         ;Segundo numero leido
    file_end resb 4                     ;Indica si se llego al final del archivo
    data resb 4                         ;Dato desencriptado
    digito_print resb 4                 ;Digito a imprimir
    

section .text
    global _start

_start:
    ;Crear archivo
    mov rax, 8                          ;sys_create
    mov rbx, outputFilename             ;Nombre del archivo que se va a leer
    mov rcx, 0777                       ;Flags
    int 0x80                            ;Llamada al sistema

    post_create:
    mov r15, rax                        ;Guardar file descriptor
    mov [fd_out], eax                   ;Guardar file descriptor
    despues:

    ;Abrir archivo y comenzar a leerlo
    jmp read_file

    ;Desencriptar el dato leido
    decrypt:
        push rax
        call modular_exponentiation


    ;Escribir el resultado en otro archivo
    mov [data], eax
    jmp writing_loop
    ; jmp print_data

    ;Continuar leyendo
    keep_reading:
    jmp reading_loop



end_program:
    close:
    mov eax, 6                           ;sys_close
    mov ebx, [fd_out]

    ;Terminar programa
    mov rax, 1         
    mov ebx, 0   
    int 0x80           