%include "modulo.asm"

section .data
    outputFilename db "output.txt"        ;Nombre del archivo que se va a escribir
    space db 32

section .bss
    data resb 4                       ;Buffer para el archivo
    fd_out resb 4
    digito_print resb 4

section .text
    global _start

_start:
    mov word [data], 103      ;PRUEBA

    mov rax, 8                          ;sys_create
    mov rbx, outputFilename             ;Nombre del archivo que se va a leer
    mov rcx, 0777                       ;Flags
    int 0x80                            ;Llamada al sistema

    mov r15, rax                        ;Guardar file descriptor
    mov [fd_out], rax                   ;Guardar file descriptor

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

            debug1:
            add rbx, 48                 ;Convertir a ASCII
            mov [digito_print], rbx     ;Guardar el digito a imprimir

            debug2:
            mov rax, 4                          ;sys_write
            mov rbx, [fd_out]                   ;File descriptor fd
            mov rcx, digito_print               ;Puntero al digito a imprimir
            mov rdx, 1                          ;Tamaño del buffer
            int 0x80                            ;Llamada al sistema

            dec r9
            dec r10

            cmp r10, 0
            jne print
    
    espacio:
    mov rax, 4                          ;sys_write
    mov rbx, [fd_out]                   ;File descriptor fd
    mov rcx, space                      ;Puntero al valor ASCII de espacio
    mov rdx, 1                          ;Tamaño del buffer
    int 0x80                            ;Llamada al sistema
        
    close:
    mov eax, 6                           ;sys_close
    mov ebx, [fd_out]

final:
    ;Terminar programa
    mov rax, 1         
    mov ebx, 0   
    int 0x80  

