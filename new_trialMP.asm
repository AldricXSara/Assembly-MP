

global _main
extern _printf, _system, _getchar, _gets

section .data
 
           
newline db 13,10,0
clr db "cls", 0

P1 db "Input DNA string: ",0
P2 db "Error: Null input!",0
P3 db "Error: Invalid input",0
P4 db "Beyond maximum length",0
P5 db "No terminator",0
P6 db "Reverse Complement: ",0
P7 db "Population Count: %d",0
P8 db "String length: ", 0

OUT1 db "DNA string is %s ",0

counter dd 0
count dd 0
intformat db "%d",0
string times 20 db 0
string2 times 20 db 0
strformat db "%s", 0
charformat db "%c", 0
section .text
_main:
    mov ebp, esp; for correct debugging
; clear screen    
    push clr
    call _system
    add esp, 4
; print input DNA string
    push P1
    call _printf
    add esp, 4
; ask for a DNA string
    push string
    call _gets
    add esp, 4
    
; print DNA String
    push string
    push OUT1
    call _printf
    add esp, 8
; newline
    push newline
    call _printf
    add esp, 4

    LEA ESI, [string]
    LEA EDI, [string2]
   
  
    MOV dword [count], 00
   
    ;checks for null input
    checkspace: CMP byte [ESI], 00
                JNE countchar
          null: push P2
                call _printf
                add esp,4
                JMP finish
    
     invalid: push P3
             call _printf
             add esp, 4
             JMP finish
     beyondlength: push P4
                   call _printf
                   add esp, 4
                   JMP finish
    
    
    countchar: CMP byte [ESI], 00
               JE end
               
    checkValid: CMP byte [ESI], 'A'
                JE inccount
                CMP byte [ESI], 'C'
                JE inccount
                CMP byte [ESI], 'G'
                JE inccount
                CMP byte [ESI], 'T'
                JE inccount
                CMP byte [ESI], '.'
                JE inccount
                
                JMP invalid
               
    inccount:  INC byte[count]
               INC ESI
               JMP countchar
            
    end: push P8
         call _printf
         add esp, 4
         push dword [count]
         push intformat
         call _printf
         add esp, 8
     
         push newline
         call _printf
         add esp, 4           
         
         CMP byte [count], 21
         JE beyondlength   
               
                     
         LEA ESI, [string]
         DEC byte [count]
         DEC byte [count]
         
         MOV EAX, [count]
         
         LEA EDI, [string2+EAX]
         
     complementA: CMP byte [ESI], 'A'
                  JNE complementC
                  MOV byte [EDI], 'T'
                  INC ESI
                  DEC EDI
     complementC: CMP byte [ESI], 'C'
                  JNE complementG
                  MOV byte [EDI], 'G'
                  INC ESI
                  DEC EDI
     complementG: CMP byte [ESI], 'G'
                  JNE complementT
                  MOV byte [EDI], 'C'
                  INC ESI
                  DEC EDI             
     complementT: CMP byte [ESI], 'T'
                  JNE checkextend
                  MOV byte [EDI], 'A'
                  INC ESI
                  DEC EDI                            
     checkextend: CMP byte [ESI], '.'
                  JE displayrev
                  CMP byte [ESI], 'A'
                  JE complementA
                  CMP byte [ESI], 'G'
                  JE complementG
                  CMP byte [ESI], 'C'
                  JE complementC
                  CMP byte [ESI], 'T'
                  JE complementT
   
   displayrev: push P6
               call _printf
               add esp, 4
               push string2
               call _printf
               add esp, 4      
               
;   palindrome:  LEA ESI, [string]
 ;               LEA EDI, [string2]
                
                   
                                 
   finish:
                
    xor eax, eax
    ret