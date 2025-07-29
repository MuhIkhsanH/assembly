bits 64
default rel

extern GetStdHandle
extern WriteFile
extern ExitProcess

section .data
    STD_OUTPUT_HANDLE equ -11

section .bss
    handle  resq 1
    written resq 1
    buffer  resb 16 

section .text
    global main

main:
    sub rsp, 40

    ; GetStdHandle(STD_OUTPUT_HANDLE)
    mov rcx, STD_OUTPUT_HANDLE
    call GetStdHandle
    mov [handle], rax

    mov rbx, 1 ; counter = 1

.loop:
    cmp rbx, 100001
    jge .done

    mov rax, rbx         
    call int_to_ascii    



    mov byte [rdi + rax], 0x0D      ; CR
    mov byte [rdi + rax + 1], 0x0A  ; LF

    mov r8, rax
    add r8, 2

    mov rcx, [handle]       
    mov rdx, rdi            
    lea r9, [written]       
    mov qword [rsp + 32], 0 
    call WriteFile

    inc rbx                 
    jmp .loop               

.done:
    xor rcx, rcx            
    call ExitProcess

; --- Fungsi int_to_ascii ---
int_to_ascii:
    push rbx            
    xor rcx, rcx        
    mov rbx, 10         

.loop2:
    xor rdx, rdx        
    div rbx             
    add dl, '0'         
    dec rdi             
    mov [rdi], dl       
    inc rcx             
    test rax, rax       
    jnz .loop2          

    mov rax, rcx        
    pop rbx             
    ret
