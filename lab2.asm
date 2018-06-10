.model small
.stack 100h
.386
.data
src db "ASSA"
dest db lengthof src dup(?)
str1 db "Not a Palindrome!$"
str2 db "Palindrome!$"
.code
main proc
mov ax,@data
mov ds,ax
mov cx,lengthof src
mov si,lengthof src
mov di,0
sub si,1
l1:
mov dl,byte ptr src[si]
mov dest[di],dl
inc di
dec si
loop l1
;mov dest[di],'$'
mov cx,lengthof src
mov di,0
;mov si,0
l2:
mov dh,src[Di]
CMP DH,dest[di]
jne l3
inc di
loop l2
jmp l4
l3:
mov ah,9
mov dx,offset str1
int 21h
jmp exit
l4:
mov ah,9
mov dx,offset str2
int 21h
exit:
mov ah,4ch
int 21h
main endp
end main