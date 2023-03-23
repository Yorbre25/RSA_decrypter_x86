%include "read_file.asm"
%include "decrypt.asm"
%include "key.asm"
%include "write_file.asm"

; El programa toma un archivo txt encriptado por medio de RSA y lo desencripta, escribiendo
; el resultado en un archivo .txt llamado output.
; A la hora de correr el programa solicita los valores de n y d de la llave privada.

section .data
    inputFilename dw "input.txt", 0       ;Nombre del archivo que se va a leer
    outputFilename dw "output.txt"        ;Nombre del archivo que se va a escribir
    space dw 32

section .bss
    ; Parametros de la llave privada
    n resb 4                            ;Numero n
    d resb 4                            ;Numero d
    ; Variables de archivos
    fd_in resb 4                        ;File descriptor
    fd_out resb 4                       ;File descriptor

    ;Variables de lectura
    buffer resb 4                       ;Buffer de lectura
    num1 resb 4                         ;Primer numero leido
    num2 resb 4                         ;Segundo numero leido
    file_end resb 4                     ;Indica si se llego al final del archivo
    
    ;Variables de desencriptacion
    data resb 4                         ;Dato desencriptado
    digito_print resb 4                 ;Digito a escribir en el archivo
    

section .text
    global _start

_start:

    ;Crear archivo
    mov rax, 8                          ;sys_create
    mov rbx, outputFilename             ;Nombre del archivo que se va a leer
    mov rcx, 0777                       ;Flags
    int 0x80                            ;Llamada al sistema

    mov r15, rax                        ;Guardar file descriptor
    mov [fd_out], eax                   ;Guardar file descriptor
    

    post_create:
    ;Obtener valores de n y d
    jmp get_inputs

    post_inputs:
    ;Abrir archivo y comenzar a leerlo
    jmp read_file

    ;Desencriptar el dato leido
    decrypt:
        push rax
        call modular_exponentiation


    ;Escribir el resultado en otro archivo
    keep_writing:
    mov [data], eax
    jmp writing_loop

    ;Continuar leyendo
    keep_reading:
    jmp reading_loop



end_program:
    ; Cerrar archivo de escritura
    mov eax, 6                           ;sys_close
    mov ebx, [fd_out]

    ;Terminar programa
    mov rax, 1         
    mov ebx, 0   
    int 0x80           