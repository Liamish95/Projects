SYS_READ   equ     0          ; read text from stdin
SYS_WRITE  equ     1          ; write text to stdout
SYS_EXIT   equ     60         ; terminate the program
STDIN      equ     0          ; standard input
STDOUT     equ     1          ; standard output
; --------------------------------
section .bss
    MaxLength equ     24         	; 24 bytes for user input
    UserInput     resb    MaxLength 	; buffer for user input
; --------------------------------
section .data
    prompt     db      "Please input some text (max 23 characters): "
    prompt_len equ     $ - prompt
    text       db      10, "When swapped you get: "
    text_len   equ     $ - text
; --------------------------------
section .text
	global _start

_start:
	; Output a prompt to user
	mov     rdx, prompt_len
	mov     rsi, prompt
	mov     rdi, STDOUT
	mov     rax, SYS_WRITE
	syscall

	; Read a string from console into uinput
	mov     rdx, MaxLength
	mov     rsi, UserInput
	mov     rdi, STDIN
	mov     rax, SYS_READ
	syscall                      ; -> RAX
	
	;Call fucntion to for swapcase
	mov rdi,UserInput
	mov rsi, rax		;Pass length of the string
	call swapcase
	
	;; Write out prompt to console
	mov     rdx, text_len
	mov     rsi, text
	mov     rdi, STDOUT
	mov     rax, SYS_WRITE
	syscall

	;; Write out string that was swapcased
	mov     rsi, UserInput
	mov	rdx, MaxLength
	mov     rdi, STDOUT
	mov     rax, SYS_WRITE
	syscall
	
	;; Exit the program
	xor     edi, edi             ; successful exit
	mov     rax, SYS_EXIT
	syscall
	

swapcase:
	push rbp
	mov rbp,rsp
	
loop:	

	mov al, [rdi]        	;Load the first character into AL
	cmp al, 'A'		;Check if the character against ascii value 'A'
	jl non_letter		;Jump to next character if the character is less than ascii value 'A' (non letter)
	cmp al, 'Z'		;If the character is greater than ascii value 'A' check if the character is less than ascii 'Z' 
	jle lowercase		;jump to lowercase if the character is less than ascii value for uppercase 'Z'
	cmp al, 'a'		;check if character is less than ascii value 'a'
	jl non_letter		;If the character is less than ascii 'a',  jump to next as it is not a valid swappable character
	cmp al, 'z'		;if it is a valid character, check if it less than ascii value 'z'
	jg non_letter		;if the character is less than ascii value 'z', jump to uppercase to swap to uppercase

				
uppercase:	
	sub al, 32		;this subtracts 32 from the ascii value of the character, swaps lowercase to uppercase
	jmp next		;then jump to the next character function
				
lowercase:    
	add al, 32		;this adds 32 to the ascii value of the character, used to swap uppercase to lowercase
	jmp next		;then jump to the next character function

next:   
	mov [rdi],al 		;put result back in memory
	sub rsi, 1		;decrement the length of the string
	cmp rsi, 0		;compare the string length to 0
	je end			;jump to end if equal to 0
	add rdi,1		;otherwise move to next char
	jmp loop		;loop back 
	
non_letter:
	add rdi, 1		;if current character is a non letter, add one and move to next character
	sub rsi, 1		;decrement length of the string
	jz end			;jump to end if equals 0
	jmp loop		;otherwise loopback

end:	
	xor rax,rax
	mov rsp,rbp
	pop rbp
	ret
	
