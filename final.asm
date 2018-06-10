.model small
.stack 100h
.data
.code
main proc
mov dh,0
mov cl,5
l1:
mov ah,3
mov bl,cl
add dh,1
mov cl,dh
l2:
mov ah,2
mov dl,42
int 21h
loop l2
mov cl,bl
mov dl,10
int 21h
mov dl,13
int 21h
loop l1
mov ah,4ch
int 21h
main endp
end main