.MODEL SMALL
.STACK 100h
.386
.DATA
STR1 DB "ENTER A VALUE TO FIND ITS FACTORIAL $"

.CODE
MAIN PROC
MOV AX,@DATA
MOV DS,AX


MOV AH,9
MOV DX,OFFSET STR1
INT 21H

CALL INDEC


CMP AX,0
JE ZEROCHECK
CMP AX,1
JE @OUTDEC
MOV BX,AX
DEC BX



SOLVE:
MUL BX
DEC BX
CMP BX,0
JE @OUTDEC
JMP SOLVE






ZEROCHECK:
INC AX

@OUTDEC:
CALL OUTDEC






MOV AH,4CH
INT 21H






MAIN ENDP




INDEC PROC
  PUSH BX
  PUSH CX
  PUSH DX
  
  BEGIN:
  MOV CX,0
  MOV BX,0
  
  MOV AH,2
  MOV DL,'?'
  INT 21h
  
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
  JMP BEGIN
  
  INDEC ENDP

outdec proc
push ax
push bx
push cx
push dx
mov bx,10
mov cx,0
cmp ax,0
jge @else
push ax
mov ah,2
mov dl,'-'
int 21h
pop ax
neg ax
@else:
mov bx,10
mov dx,0
div bx
push dx
inc cx
cmp ax,0
jnz @else
print_label:
pop dx
mov ah,2
add dl,48
int 21h
loop print_label
pop dx
pop cx
pop bx
pop ax
RET
outdec endp

END MAIN