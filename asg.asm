.model small
.stack 100h
.data
str2 db "Error$"
str3 db "Input a Character$"
str1 db "Do You Want to Continue?$"
.code
main proc
mov cx,1
@while:
mov ax,@data
mov ds,ax
mov ah,9
mov dx,offset str3
int 21h
mov dl,10
int 21h
mov dl,13
int 21h
mov ah,1
int 21h
mov bl,'a'
cmp al,bl
jge chks
jmp chkg1
chks:
mov bl,'z'
cmp al,bl
jle sml
jmp error
sml:
mov ah,2
sub al,32
mov dl,al
int 21h
jmp ask
chkg1:
mov bl,'A'
cmp al,bl
jge chkg2
jmp error
chkg2:
mov bl,'Z'
cmp al,bl
jle grt
jmp error
grt:
mov ah,2
add al,32
mov dl,al
int 21h
jmp ask
error:
mov ah,9
mov dx,offset str2
int 21h
ask:
mov ah,9
mov dx,offset str1
int 21h
inc cx
mov ah,1
int 21h
cmp al,'y'
je @while
cmp al,'Y'
je @while
cmp al,'n'
je exit
cmp al,'N'
je exit
jmp error
exit:
mov ah,4ch
int 21h
main endp
end main