section .data
    filename db "5.txt", 0      ;Nombre del archivo
;    buffer_size equ 1024        ;Tamaño del buffer

section .bss
    buffer resb 4     ;Buffer para el archivo
    fd resb 4          ;File descriptor

section .text
    global _start

_start:
    mov rax, 5                  ;sys_open
    mov rbx, filename           ;Nombre del archivo
    mov rcx, 0                  ;Flags
    mov rdx, 0777               ;Permisos
    int 0x80                    ;Llamada al sistema

    ; NO SE VERIFICAN ERRORES
    mov [fd], rax                ;Guardar file descriptor

    leer:
    mov rax, 3                  ;sys_read
    mov rbx, [fd]               ;File descriptor fd
    mov rcx, buffer             ;Buffer
    mov rdx, 4                  ;Tamaño del buffer
    int 0x80                    ;Llamada al sistema

    


final:
    ;Terminar programa
    mov rax, 1         
    mov ebx, 0   
    int 0x80           