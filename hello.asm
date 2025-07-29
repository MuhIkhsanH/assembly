bits 64
default rel

extern GetStdHandle
extern WriteFile
extern ExitProcess

section .data
  msg db "Hello, World!", 0x0D, 0x0A
  msglen equ $ - msg
  STD_OUTPUT_HANDLE equ -11

section .bss
  handle resq 1
  written resq 1

section .text
  global main

main:
  sub rsp, 8             ; align stack
  mov rcx, STD_OUTPUT_HANDLE
  call GetStdHandle
  mov [handle], rax

  sub rsp, 32            ; shadow space
  mov rcx, rax           ; handle
  lea rdx, [rel msg]     ; buffer
  mov r8, msglen         ; length
  lea r9, [rel written]  ; bytes written
  mov qword [rsp], 0     ; lpOverlapped = NULL
  call WriteFile
  add rsp, 32            ; restore space

  xor rcx, rcx           ; exit code 0
  call ExitProcess
