; %include "ascii_dec.inc"
%include "modulo.asm"

section .data
    outputFilename db "output.txt"        ;Nombre del archivo que se va a escribir
    space db 32

section .bss
    result resb 4                       ;Buffer para el archivo
    digitToPrint resb 4                 ;Buffer para el dígito a imprimir
    fdOut  resb 4                           ;File descriptor

section .text
    global _start

_start:
    mov word [result], 6123  ;DE PRUEBA

    mov rax, 8                          ;sys_create
    mov rbx, outputFilename             ;Nombre del archivo que se va a leer
    mov rcx, 0777                          ;Flags
    int 0x80                            ;Llamada al sistema

    ; NO SE VERIFICAN ERRORES
    
    mov r15, rax                        ;Guardar file descriptor
    mov [fdOut], rax                    ;Guardar file descriptor

    inicial:
    xor rax, rax                        ;Limpiar rax
    unga:
    movzx eax, word [result]            ;Guardar el resultado para dividirlo
    mov rsi, 10                         ;Divisor
    mov rbx, 0                          ;contador de dígitos
    ;Contar el número de digitos del resultado
    numDigits:
        xor rdx, rdx            ;Limpiar 
        limpio:
        div rsi                 ;Dividir el número por 10
        result1:
        inc rbx                 ;Incrementar el contador de dígitos
        cmp rax, 0              ;Verificar si el número es 0
        jnz numDigits    

    ;Aislar cada dígito para imprimirlo en ASCII
    mov r9, rbx                 ;Guardar el número de dígitos
    movzx eax, word [result]

    writeResult:
        mov r8, r9                  ;Numero de digitos
        sub r8, 1                   ;Numero de digitos que hay que eliminar

        ;Eliminar digitos antes del numero en pos r9
        getDigit:
            cmp r8, 0               ;Comprar si ya se eliminaron todos los dígitos
            jz finDig
            xor rdx, rdx            ;Limpiar
            div rsi                 ;Dividir el número por 10
            dec r8                  
            jmp getDigit
        finDig:

        ;Eliminar digitos despues del numero en pos r9
        ; a mod(y)
        push rax                    ;Push del valor de a
        push 10                     ;Push del valor de y
        call mod

        mov [digitToPrint], rax     ;Guardar el digito que se va a imprimir
        add byte [digitToPrint], 48 ;Convertir a ASCII
        
        mov [fdOut], r15
        write:
        mov rax, 4                          ;sys_write
        mov rbx, [fdOut]                    ;File descriptor fd
        mov rcx, digitToPrint               ;Puntero al digito a imprimir
        mov rdx, 1                          ;Tamaño del buffer
        int 0x80                            ;Llamada al sistema

        checkeo:
        dec r9
        movzx eax, word [result]
        cmp r9, 0
        jnz writeResult

    ;Separar cada numero con un espacio " "
    espacio:
    mov rax, 4                          ;sys_write
    mov rbx, [fdOut]                    ;File descriptor fd
    mov rcx, space                      ;Puntero al valor ASCII de espacio
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