%include "readFile.asm"
%include "decrypt.asm"
%include "write_file.asm"

section .data
    inputFilename db "5.txt", 0         ;Nombre del archivo que se va a leer
    outputFilename db "output.txt"        ;Nombre del archivo que se va a escribir
    space db 32
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


    ;Abrir archivo y comenzar a leerlo
    jmp read_file

    ;Desencriptar el dato leido
    decrypt:
        push rax
        call modular_exponentiation


    ;Escribir el resultado en otro archivo
    mov [data], byte 103
    jmp primero
    ; jmp print_data

    ;Continuar leyendo
    keep_reading:
    jmp reading_loop


end_program:
    ; close:
    ; mov eax, 6                           ;sys_close
    ; mov ebx, [fd_out]

    ;Terminar programa
    mov rax, 1         
    mov ebx, 0   
    int 0x80           