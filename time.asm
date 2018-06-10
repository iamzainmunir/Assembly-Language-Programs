.model small
.stack 100h
.386
.data


showtime macro min,sec
mov ah,0
mov al,min
call outdec
mov ah,2
mov dl,':'
int 21h
mov ah,0
mov al,sec
call outdec

endm


linechanger macro
push ax
push dx

mov ah,2
mov dl,13
int 21h
mov dl,10
int 21h


pop dx
pop ax
endm
time db "10 secs compeleted now $"
dmin db ?
dsec db ?
.code
main proc
mov ax,@data
mov ds,ax

mov ah,2ch
int 21h
showtime cl,dh
linechanger

add dh,10
mov al,60
cmp dh,al
jl khatam
sub dh,60
add cl,1
mov dmin,cl
mov dsec,dh
showtime cl,dh
jmp l1

khatam:
linechanger
mov dmin,cl
mov dsec,dh
showtime cl,dh


l1:
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




jmp l1


timecomplete:
mov ah,9
mov dx,offset time
int 21h











mov ah,4ch
int 21h
main endp




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

end main