
.MODEL SMALL
.STACK 200h
.386
entered MACRO 
MOV ah,2
MOV dl,10
INT 21h

MOV ah,2
MOV dl,13
INT 21h


ENDM 


.DATA

ended DB "     END GAME$"
point DB 0
wel DB "                             TYPING MASTER GAME$"
opt1 DB "press 1 to play game$"
opt2 DB "press 2 to exit$"
str1 DB "alphabets$","umbrellas$","kangrooos$","seileings$","complexes$","pegionhol$"
str2 DB 10 dup(?)
var DW ?
keyboard struct
inputcount DB ?
buffer DB 20 dup(?)

keyboard ends

INPUT DB 20 dup(?)

cminute db ?
cseconds db ?
dmin db ?
dsec db ?

.CODE

MAIN PROC

MOV ax,@data
MOV ds,ax
MOV es,ax

MOV ah,9
MOV dx,offset WEL 
INT 21h
ENTERED 
MOV ah,9

MOV ah,9
MOV dx,offset OPT1  
INT 21h

ENTERED 
MOV ah,9
MOV dx,offset OPT2 
INT 21h
ENTERED 

MOV ah,1
INT 21h

CMP al,'2'
JE ending

CMP al,'1'
JNE ending
ENTERED 

MOV SI,0
MOV dx,offset STR1  
MOV cx,6
MOV var,cx

PUSH AX
PUSH BX
PUSH CX
PUSH DX

mov ah,2ch
int 21h

add dh,10 ;abhe 10 secs rakha he yaha change karna he
mov al,60
cmp dh,al
jl khatam
sub dh,60
add cl,1
mov dmin,cl
mov dsec,dh
jmp end4

khatam:
mov dmin,cl
mov dsec,dh

end4:

POP DX
POP CX
POP BX
POP AX




L:
PUSH AX
PUSH BX
PUSH CX
PUSH DX
mov ah,2ch
int 21h
mov al,dmin
mov bl,cl
cmp bl,al
jg timecomplete
jl out1
mov al,dsec
mov bl,dh
cmp bl,al
jge timecomplete



out1:






POP DX
POP CX
POP BX
POP AX



MOV ah,9

INT 21h
MOV bx,dx

MOV ah,2
MOV dl,10
INT 21h

MOV si,0
i:
MOV ah,1
INT 21h
CMP al,13
JE OUTER   
MOV INPUT[si],al
INC si
JMP I 
outer:

MOV input[si],'$'
;comments

MOV di,bx
MOV si,offset INPUT 

MOV cx,9 
repe CMPSB 
JNE exit
INC POINT 
exit:


;comments

MOV ah,2
MOV dl,10
INT 21h
ADD BX,10
MOV dx,bx

MOV cx,var
DEC var
 
DEC CX
CMP CX,0
JNE L 


TIMECOMPLETE:

MOV ah,2
MOV dl,10
INT 21h


MOV ah,2
MOV dl,'?'
INT 21h

ADD point,48
MOV ah,2
MOV dl,point
INT 21h


ending:


MOV ah,9
MOV dx,offset ended 
INT 21h



MOV ah,4ch 
INT 21h



MAIN ENDP
END MAIN