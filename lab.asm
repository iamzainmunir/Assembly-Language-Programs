.model small
.stack 100h
.386
.data
src db 'T','h','i','s',' ','i','s',' ','a',' ','S','t','r','i','n','g','$'
dest db lengthof src dup(?)
.code
main proc
mov ax,@data
mov ds,ax
mov cx,lengthof src
mov si,lengthof src
sub si,2
mov di,0
l1:
mov dl,byte ptr src[si]
mov dest[di],dl
dec si
inc di
loop l1
mov dest[di],'$'
mov ah,9
mov dx,offset src
int 21h
mov ah,2
mov dl,10
int 21h
mov dl,13
int 21h
mov ah,9
mov dx,offset dest
int 21h
mov ah,4ch
int 21h
main endp
end main