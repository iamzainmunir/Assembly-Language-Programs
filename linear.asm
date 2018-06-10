.MODEL SMALL
.STACK 100h
.386
.DATA
ARR DW 17,24,31,49,15,6,87,108,19
STR1 DB "Enter your value: $"
STR2 DB "Value Found At Index: $"
STR3 DB "Error! Enter digit only!$"
STR4 DB "Value not found!$"
.CODE
  MAIN PROC
  MOV AX,@DATA
  MOV DS,AX
  MOV SI,0
  MOV CX,LENGTHOF ARR
  S_PRINT:
  MOV AX,ARR[SI]
  CALL OUTDEC
  MOV AH,2
  MOV DL,","
  INT 21h
  ADD SI,2
  LOOP S_PRINT
  MOV DL,13
  INT 21h
  MOV DL,10
  INT 21h
  MOV AH,9
  MOV DX,OFFSET STR1
  INT 21h
  MOV AH,2
  MOV DL,13
  INT 21h
  MOV DL,10
  INT 21h
  MOV AX,0
  CALL INDEC
  CALL LINEAR
  MOV AH,4Ch
  INT 21h
  MAIN ENDP

  ; ///////////////////////////////LINEAR//////////////////////////////////////////////////
  
  LINEAR PROC
  PUSH BX
  PUSH CX
  PUSH DX
  MOV CL,LENGTHOF ARR
  MOV DI,0
  MOV CH,0
  START:
  MOV BX,ARR[DI]
  CMP BX,AX
  JE VFOUND
  INC CH
  ADD DI,2
  DEC CL
  CMP CL,0
  JNE START
  MOV AH,9
  MOV DX,OFFSET STR4
  INT 21h
  JMP EXIT_LINEAR
  VFOUND:
  MOV AH,9
  MOV DX,OFFSET STR2
  INT 21h
  MOV AH,2
  ADD CH,48
  MOV DL,CH
  INT 21h
  EXIT_LINEAR:
  POP BX
  POP CX
  POP DX
  RET
  LINEAR ENDP
  
  ; //////////////////////////////LINEAR//////////////////////////////////////////////////
  
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
   OUTDEC PROC
  PUSH AX
  PUSH BX
  PUSH CX
  PUSH DX
  
  MOV CX,0
  CMP AX,0
  JGE @ELSE
  PUSH AX
  MOV AH,2
  MOV DL,'-'
  INT 21h
  POP AX
  NEG AX
  @ELSE:
  MOV BX,10
  MOV DX,0
  DIV BX
  PUSH DX
  INC CX
  CMP AX,0
  JNZ @ELSE
  
  ; MOV AH,9
  ; MOV DX,OFFSET STR2
  ; INT 21h
  ; MOV AH,2
  ; MOV DL,' '
  ; INT 21h
  PRINT_LABEL:
  MOV AH,2
  POP DX
  ADD DX,48
  INT 21h
  LOOP PRINT_LABEL
  
  POP DX
  POP CX
  POP BX
  POP AX
  
  RET
  OUTDEC ENDP
;////////////////////////////////OUTDEC///////////////////////////////////////////////
  
    
   END MAIN
