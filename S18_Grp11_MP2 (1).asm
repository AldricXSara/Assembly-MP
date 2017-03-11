%include "io.inc"

section .data
len dd 0

section .bss
ARR resd 1000

section .text
global CMAIN
CMAIN:
    PRINT_STRING "How many integers? "
    GET_UDEC 4, [len]
    NEWLINE
    PRINT_STRING "Input the integers (enter after each):"
    NEWLINE
    LEA ESI, [ARR]
    XOR ECX, ECX
    MOV ECX, [len]
GetInts:    
    GET_DEC 4, [ESI]
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
    NEWLINE
    PRINT_STRING "Sorted Integers:"
    NEWLINE                    
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