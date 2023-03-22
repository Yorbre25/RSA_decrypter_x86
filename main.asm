%include "readFile.asm"
%include "Descenc2.asm"

section .data
    inputFilename db "5.txt", 0         ;Nombre del archivo que se va a leer
    n db 50
    d db 200

section .bss
    fd_in resb 4                        ;File descriptor
    buffer resb 4                       ;Buffer de lectura
    num1 resb 4                         ;Primer numero leido
    num2 resb 4                         ;Segundo numero leido
    file_end resb 4                     ;Indica si se llego al final del archivo
    

section .text
    global _start

_start:
    jmp read_file

    decrypt:
        push rax
        call modularExponentiation

    ; jmp escribir
    result_mod:
    jmp reading_loop


end_program:
    ;Terminar programa
    mov rax, 1         
    mov ebx, 0   
    int 0x80           