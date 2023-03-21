%include "AsciiToDec.inc"

section .data
    inputFilename db "5.txt", 0         ;Nombre del archivo que se va a leer
    outputFilename db "6.txt", 0        ;Nombre del archivo que se va a escribir

section .bss
    buffer resb 4                       ;Buffer para el archivo
    fd resb 4                           ;File descriptor

section .text
    global _start

_start:
    mov rax, 5                          ;sys_open
    mov rbx, inputFilename              ;Nombre del archivo que se va a leer
    mov rcx, 0                          ;Flags
    mov rdx, 0777                       ;Permisos
    int 0x80                            ;Llamada al sistema

    ; NO SE VERIFICAN ERRORES
    mov [fd], rax                       ;Guardar file descriptor

    leer:
    mov rax, 3                          ;sys_read
    mov rbx, [fd]                       ;File descriptor fd
    mov rcx, buffer                     ;Buffer
    mov rdx, 4                          ;Tamaño del buffer
    int 0x80                            ;Llamada al sistema

    ;Llamar función ascii_to_dec
    push $4                             
    push buffer
    call ascii_to_dec

    mov [buffer], rax ;esto es de prueba

final:
    ;Terminar programa
    mov rax, 1         
    mov ebx, 0   
    int 0x80           