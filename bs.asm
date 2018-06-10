.MODEL SMALL
.STACK 100h
.386
.DATA
     ask db "Enter your value: $"
     fnd db "Value Found...$"
     ntfnd db "Value Not Found...$"
     index db "Number is at Index : $"
    
     arr byte 1,2,3,4,5,6,7,8,9,10
     divisor byte 2
     lower dw 0
     higher dw 0
     mid dw 0

.CODE
MAIN PROC
    mov ax, @data
    mov ds, ax
    mov cx, lengthof arr
    mov higher, lengthof arr
    mov ah,9
    mov dx,offset ask
    int 21h
    call INDEC
    push ax
    
    BINARY_SEARCH:
    mov bx, lower
    mov mid, bx
    mov bx, higher
    add mid, bx
    mov ax, mid
    div divisor
    mov ah, 0
    mov mid, ax
    pop ax
    mov bh, 0
    mov si, mid
    mov bl, arr[si]
    cmp al, bl
    push ax
    je FOUND
    jl LEFT_HALF
    jg RIGHT_HALF
    mov bx, lower
    cmp higher, bx
    jg BINARY_SEARCH
    jmp NOT_FOUND
    LEFT_HALF:
    mov bx, mid
    mov higher, bx
    dec higher
    jmp BINARY_SEARCH
    RIGHT_HALF:
    mov bx, mid
    mov lower, bx
    inc lower
    jmp BINARY_SEARCH
    NOT_FOUND:
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
    mov ah, 9
    mov dx,offset ntfnd
    int 21h
    jmp exit
    FOUND:
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
    mov ah, 9
    mov dx,offset fnd
    int 21h
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
    mov ah, 9
    mov dx,offset index
    int 21h
    mov ah, 2
    mov dx, mid
    add dx, 48
    int 21h
    exit:
    mov ah, 4ch
    int 21h
    

MAIN ENDP


INDEC PROC
  PUSH BX
  PUSH CX
  PUSH DX
  
  BEGIN:
  MOV CX,0
  MOV BX,0
  
  
  
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
mov ah, 2
mov dl, 10
int 21h
mov dl, 13
int 21h
pop dx
mov ah,2
add dl,48
int 21h
loop print_label
mov ah, 4ch
int 21h
pop dx
pop cx
pop bx
pop ax
RET
outdec endp

END MAIN