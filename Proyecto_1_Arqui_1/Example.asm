.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data

sum dword ?

.code 
main proc
	mov eax, 7
	add eax, 4
	mov sum, eax

	invoke ExitProcess, 0

main endp
end main
