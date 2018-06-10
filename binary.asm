.MODEL SMALL
.STACK 100h
.386
.DATA
STR1 DB "Enter your value:$"
STR2 DB "Binary digits of given value:$"
STR3 DB "Error! Enter digit only!$"
.CODE
  MAIN PROC
  MOV AX,@DATA
  MOV DS,AX
  MOV AH,9
  MOV DX,OFFSET STR1
  INT 21h
  CALL INDEC
  ; MOV BX,AX
  ; MOV CX,16
  ; LABEL12:
  ; RCL BX,1
  ; JC ONE
  ; MOV AX,0
  ; CALL OUTDEC
  
  ; ONE:
  ; MOV AX,1
  ; CALL OUTDEC
  ; END_B:
  
  ; LOOP LABEL12
  
  
  
  PUSH AX
  MOV AH,9
  MOV DX,OFFSET STR2
  INT 21h
  MOV CX,16
  LABEL1:
  POP AX
  ROL AX,1
  PUSH AX
  JC ONE
  MOV AH,2
  MOV DL,'0'
  INT 21h
  JMP CAL
  ONE:
  MOV AH,2
  MOV DL,'1'
  INT 21h
  JMP CAL
  ; CALL OUTDEC
  CAL:
  LOOP LABEL1

  MOV AH,4Ch
  INT 21h
  MAIN ENDP

  ;///////////////////////////////INDEC/////////////////////////////////////////////////
  INDEC PROC
  PUSH BX
  PUSH CX
  PUSH DX
  
  BEGIN:
  MOV CX,0
  MOV BX,0
  
  MOV AH,2  
  MOV DL,' '
  INT 21h
  
  MOV AH,1
  INT 21h
  
  CMP AL,'-'
  JE MINUS
  CMP AL,'+'
  JE PLUS
  JMP @LOOP
  
  MINUS:
  MOV CX,1
  
  PLUS:
  INT 21h
  
  @LOOP:
  
  CMP AL,'0'
  JL INVALID
  CMP AL,'9'
  JG INVALID
  
  SUB AL,48
  MOV AH,0
  PUSH AX
  MOV AX,10
  MUL BX
  POP BX
  ADD BX,AX
  
  MOV AH,1
  INT 21h
  
  CMP AL,13
  JNE @LOOP
  
  MOV AX,BX
  CMP CX,0
  JE EXIT
  
  NEG AX
  
  EXIT:
  POP DX
  POP CX
  POP BX
  
  RET
  
  INVALID:
  MOV AH,2
  MOV DL,10
  INT 21h
  MOV DL,13
  INT 21h
  MOV AH,9
  MOV DX,OFFSET STR3
  INT 21h
  JMP BEGIN
  
  INDEC ENDP
  
  
  ;///////////////////////////////INDEC/////////////////////////////////////////////////
  
  
  
;/////////////////////////////////OUTDEC////////////////////////////////////////////////  
   ; OUTDEC PROC
  ; PUSH AX
  ; PUSH BX
  ; PUSH CX
  ; PUSH DX
  
  ; MOV CX,0
  ; CMP AX,0
  ; JGE @ELSE
  ; PUSH AX
  ; MOV AH,2
  ; MOV DL,'-'
  ; INT 21h
  ; POP AX
  ; NEG AX
  ; @ELSE:
  ; MOV BX,10
  ; MOV DX,0
  ; DIV BX
  ; PUSH DX
  ; INC CX
  ; CMP AX,0
  ; JNZ @ELSE
  
  ; MOV AH,9
  ; MOV DX,OFFSET STR2
  ; INT 21h
  ; MOV AH,2
  ; MOV DL,' '
  ; INT 21h
  ; PRINT_LABEL:
  ; POP DX
  ; ADD DX,48
  ; INT 21h
  ; LOOP PRINT_LABEL
  
  ; POP DX
  ; POP CX
  ; POP BX
  ; POP AX
  
  ; RET
  ; OUTDEC ENDP
;////////////////////////////////OUTDEC///////////////////////////////////////////////
  
   END MAIN