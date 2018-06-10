.model small
.stack 100h
.386
.data
str1 db "Hamza's Laaaaaaaaaaaaptop$"
str2 db "The String contains:$"
str3 db "Spaces = $"
str4 db "Digits = $"
str5 db "Vowels = $"
str6 db "Consonants = $"
str7 db "Symbols = $"
spaces dw 0
digits dw 0
vowels dw 0
consonants dw 0
symbols dw 0
.code
main proc
mov ax,@data
mov ds,ax
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
mov cl,lengthof str1
mov si,0
loop1:
cmp str1[si],32
je spc
jg chk1
spc:
inc spaces
jmp exit
chk1:
cmp str1[si],48
jl sym
jge chk2
sym:
inc symbols
jmp exit
chk2:
cmp str1[si],57
jle dig
jg chk3
dig:
inc digits
jmp exit
chk3:
cmp str1[si],65
jl sym
cmp str1[si],90
jle alpha
jg chk5
alpha:
cmp str1[si],65
je vow
cmp str1[si],69
je vow
cmp str1[si],73
je vow
cmp str1[si],79
je vow
cmp str1[si],85
je vow
jmp cons
vow:
inc vowels
jmp exit
chk5:
cmp str1[si],96
jle sym
jg chk6
cons:
inc consonants
jmp exit
chk6:
cmp str1[si],122
jg sym
cmp str1[si],97
je vow
cmp str1[si],101
je vow
cmp str1[si],105
je vow
cmp str1[si],111
je vow
cmp str1[si],117
je vow
jmp cons
exit:
inc si
dec cl
jne loop1
add vowels,48
add consonants,48
add spaces,48
add digits,48
add symbols,48
mov ah,9
mov dx,offset str3
int 21h
movzx ax,spaces
call outdec
mov ah,2
mov dl,10
int 21h
mov dl,13
int 21h
mov ah,9
mov dx,offset str4
int 21h
movzx ax,digits
call outdec
mov ah,2
mov dl,10
int 21h
mov ah,2
mov dl,13
int 21h
mov ah,9
mov dx,offset str5
int 21h
movzx ax,vowels
call outdec
mov ah,2
mov dl,10
int 21h
mov ah,2
mov dl,13
int 21h
mov ah,9
mov dx,offset str6
int 21h
movzx ax,consonants
call outdec
mov ah,2
mov dl,10
int 21h
mov ah,2
mov dl,13
int 21h
mov ah,9
mov dx,offset str7
int 21h
dec symbols
movzx ax,symbols
call outdec
mov ah,2
mov dl,10
int 21h
mov ah,2
mov dl,13
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
;mov bx,10
mov dx,0
div bx
push dx
inc cx
cmp ax,0
jnz @else
mov ah,2
print_label:
pop dx
add dx,48
int 21h
loop print_label
pop dx
pop cx
pop bx
pop ax
ret
outdec endp
end main