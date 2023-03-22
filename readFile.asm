; %include "AsciiToDec.inc"

section .data
    inputFilename db "5.txt", 0         ;Nombre del archivo que se va a leer

section .bss
    buffer resb 4                       ;Buffer para el archivo
    fd_in resb 4                           ;File descriptor
    spaceCounter resb 4                 ;Contador de espacios
    num1 resb 4                       ;Resultado
    num2 resb 4                       ;Resultado

section .text
    global _start

_start:
    mov rax, 5                          ;sys_open
    mov rbx, inputFilename              ;Nombre del archivo que se va a leer
    mov rcx, 0                          ;Flags
    mov rdx, 0777                       ;Permisos
    int 0x80                            ;Llamada al sistema

    ;NO SE VERIFICAN ERRORES
    mov [fd_in], rax                       ;Guardar file descriptor

    mov byte [spaceCounter], 0                   ;Inicializar contador de espacios
    mov r15, 10                         
    leer:
        leer_num1:
            ;Leer un byte del archivo
            mov rax, 3                          ;sys_read
            mov rbx, [fd_in]                       ;File descriptor fd_in
            mov rcx, buffer                     ;Buffer
            mov rdx, 1                          ;Tamaño del buffer
            int 0x80                            ;Llamada al sistema

            ;Verificar si el valor es " ". Si lo es, romber el ciclo
            xor rax, rax
            mov al, byte [buffer]
            debug1:
            cmp rax, 32                         ;Checkear si el valor leido es un espacio
            je break_num1                    
            cmp rax, 10                         ;Checkear si el valor leido es un espacio
            je break_loop                 
 
            xor rbx, rbx
            xor rax, rax
            mov bl, byte [buffer]               ;Tomar valor leido
            sub rbx, 48                         ;Pasarlo a decimal
            nose1:
            mov rax, [num1]
            mul r15                             ;Multiplicar por 10
            add rax, rbx                        ;Sumar el valor leido
            mov [num1], rax                  ;Guardar resultado

            jmp leer_num1
        break_num1:

    ;Hacer un shift left a num1
    mov rbx, [num1]                  ;Tomar numero leido
    shl rbx, 8                       ;Hacerle un shift left de 8
    mov [num1], rbx                  ;Guardar resultado

        leer_num2:
            ;Leer un byte del archivo
            mov rax, 3                          ;sys_read
            mov rbx, [fd_in]                       ;File descriptor fd_in
            mov rcx, buffer                     ;Buffer
            mov rdx, 1                          ;Tamaño del buffer
            int 0x80                            ;Llamada al sistema

            ;Verificar si el valor es " ". Si lo es, romber el ciclo
            xor rax, rax
            mov al, byte [buffer]
            debug2:
            cmp rax, 32                         ;Checkear si el valor leido es un espacio
            je break_num2   
            cmp rax, 10                         ;Checkear si el valor leido es un espacio
            je break_loop                 
 
            
            xor rbx, rbx
            xor rax, rax
            mov bl, byte [buffer]               ;Tomar valor leido
            sub rbx, 48                         ;Pasarlo a decimal
            nose2:
            mov rax, [num2]
            mul r15                             ;Multiplicar por 10
            add rax, rbx                        ;Sumar el valor leido
            mov [num2], rax                     ;Guardar resultado

            jmp leer_num2   
        break_num2:

        ;Sumar resultados
        movzx rax, word [num1]
        movzx rbx, word [num2]
        debug3:
        add eax, ebx

        ; CORRER ALGORITMO CON EL RESULTADO (RAX)

        jmp leer




    break_loop:
    ;Cerrar archivo
    mov eax, 6
    mov ebx, [fd_in]
    int  0x80 

final:
    ;Terminar programa
    mov rax, 1         
    mov ebx, 0   
    int 0x80           