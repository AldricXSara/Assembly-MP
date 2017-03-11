%include "io.inc"
global _main
extern _printf, _gets, _scanf

section .data
newline db 13,10,0
len db 0
input db 0
prompt1 db "How many integers? ", 0 
prompt2 db "Input the integers: ", 0
prompt3 db "Sorted integers", 0
section .bss
ARR resd 1000

section .text

_main:
    mov ebp, esp; for correct debugging
    push prompt1
    call _printf
    add esp, 4
    push len
    call _gets
    add esp, 4
    push newline
    call _printf
    add esp, 4
    push prompt2
    call _printf
    add esp, 4
    push newline
    call _printf
    add esp, 4
;    LEA ESI, [ARR]
    XOR ECX, ECX
    MOV ECX, [len]
    
GetInts:                        ;there is an error here
    push input
    call _gets
    add esp, 4
    MOV ESI, [input]
    MOV dword [input], 0x00
    ADD ESI, 0x04
    
    LOOP GetInts

    XOR ECX, ECX
    MOV ECX, [len]
    DEC ECX 
L1: 
    MOV EBX, ECX
    LEA ESI, [ARR]
  L2:
    MOV EAX, [ESI]
    MOV EDX, [ESI+4]
    CMP EAX, EDX
    JG Swap     
A:  ADD ESI, 0x04
    LOOP L2
    MOV ECX, EBX
    LOOP L1
    JMP PrintInts

Swap:
    MOV dword[ESI], EDX
    MOV dword[ESI+4], EAX
    JMP A

PrintInts:
    push newline
    push prompt3
    call _printf
    add esp, 8
    push newline
    call _printf
    add esp, 4                  
    LEA ESI, [ARR]
    XOR ECX, ECX
    MOV ECX, [len]
PrintLoop:
    PRINT_DEC 4, [ESI]
    NEWLINE
    ADD ESI, 0x04
    DEC ECX                 ;LOOP doesn't work... "short jump out of range" error :(
    CMP ECX, 0x00000000
    JNE PrintLoop
        
END:xor eax, eax
    ret