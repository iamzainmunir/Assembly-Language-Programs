.MODEL SMALL
.STACK 100h
.386
.DATA 
STR1 DB "ASAD"
.CODE
MAIN PROC

MOV AX,@DATA
MOV DS,AX

MOV CX,LENGTHOF STR1
MOV SI,OFFSET STR1
ADD SI,3
CLD

REV:

LODSB

MOV DL,AL
MOV AH,2
INT 21H
SUB SI,2
LOOP REV

MOV AH,4CH
INT 21H
MAIN ENDP
END MAIN