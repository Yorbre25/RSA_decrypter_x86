section .data
    outputFilename db "output.txt"        ;Nombre del archivo que se va a escribir

section .bss
    result resb 1                       ;Buffer para el archivo
    fdOut  resb 4                           ;File descriptor

section .text
    global _start

_start:
    mov byte [result], 48   ;DE PRUEBA

    mov rax, 8                          ;sys_create
    mov rbx, outputFilename             ;Nombre del archivo que se va a leer
    mov rcx, 0777                          ;Flags
    int 0x80                            ;Llamada al sistema

    ; NO SE VERIFICAN ERRORES
    mov [fdOut], rax                       ;Guardar file descriptor

    write:
    mov rax, 4                          ;sys_write
    mov rbx, [fdOut]                    ;File descriptor fd
    mov rcx, result                     ;Buffer
    mov rdx, 1                          ;Tamaño del buffer
    int 0x80                            ;Llamada al sistema

    close:
    mov eax, 6                           ;sys_close
    mov ebx, [fdOut]

final:
    ;Terminar programa
    mov rax, 1         
    mov ebx, 0   
    int 0x80   