.model small
.stack 100h
.data
str1 db "Press a Key!$"
str2 db "Must be a Character or a Digit!$"
str3 db "Follow the Instructions!$"
str4 db "This is a Digit!$"
str5 db "This is a Vowel!$"
str6 db "This is a Consonent!$"
str7 db "Continue? (y/n)$"
.code
main proc
mov ax,@data
mov ds,ax
start:
mov ah,2
mov dl,10
int 21h
mov dl,13
int 21h
mov ah,9
mov dx,offset str1
int 21h
mov ah,2
mov dl,10
int 21h
mov dl,13
int 21h
mov ah,9
mov dx,offset str2
int 21h
mov ah,2
mov dl,10
int 21h
mov dl,13
int 21h
mov ah,1
int 21h
mov cl,al
cmp cl,48
jl wrng
jge chk
wrng:
mov ah,2
mov dl,10
int 21h
mov dl,13
int 21h
mov ah,9
mov dx,offset str3
int 21h
mov ah,2
mov dl,10
int 21h
mov dl,13
int 21h
jmp opt
chk:
cmp cl,57
jle dig
jmp chk2
dig:
mov ah,2
mov dl,10
int 21h
mov dl,13
int 21h
mov ah,9
mov dx,offset str4
int 21h
mov ah,2
mov dl,10
int 21h
mov dl,13
int 21h
jmp opt
chk2:
cmp cl,65
jge alpha
jl wrng
alpha:
cmp cl,65
je vow
cmp cl,69
je vow
cmp cl,73
je vow
cmp cl,79
je vow
cmp cl,85
je vow
jmp chk3
vow:
mov ah,2
mov dl,10
int 21h
mov dl,13
int 21h
mov ah,9
mov dx,offset str5
int 21h
mov ah,2
mov dl,10
int 21h
mov dl,13
int 21h
jmp opt
chk3:
cmp cl,90
jle cns
jmp chk4
cns:
mov ah,2
mov dl,10
int 21h
mov dl,13
int 21h
mov ah,9
mov dx,offset str6
int 21h
mov ah,2
mov dl,10
int 21h
mov dl,13
int 21h
jmp opt
chk4:
cmp cl,97
jge salpha
jl wrng
salpha:
cmp cl,97
je vow
cmp cl,101
je vow
cmp cl,105
je vow
cmp cl,111
je vow
cmp cl,117
je vow
jmp chk5
chk5:
cmp cl,122
jle cns
jmp wrng
opt:
mov ah,2
mov dl,10
int 21h
mov dl,13
int 21h
mov ah,9
mov dx,offset str7
int 21h
mov ah,2
mov dl,10
int 21h
mov dl,13
int 21h
mov ah,1
int 21h
mov cl,al
cmp cl,89
je start
cmp cl,121
je start
cmp cl,78
je exit
cmp cl,110
je exit
jmp opt
exit:
mov ah,4ch
int 21h
main endp
end main