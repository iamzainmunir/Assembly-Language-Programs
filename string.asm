.model small
.stack 100h
.386
.data
str1 db "Hamza's Laptop$"
str2 db "The String contains:$"
str3 db "Spaces = $"
str4 db "Digits = $"
str5 db "Vowels = $"
str6 db "Consonants = $"
str7 db "Symbols = $"
spaces dw ?
digits dw ?
vowels dw ?
consonants dw ?
symbols dw ?
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
mov ah,2
mov dx,spaces
int 21h
mov dl,10
int 21h
mov dl,13
int 21h
mov ah,9
mov dx,offset str4
int 21h
mov ah,2
mov dx,digits
int 21h
mov dl,10
int 21h
mov dl,13
int 21h
mov ah,9
mov dx,offset str5
int 21h
mov ah,2
mov dx,vowels
int 21h
mov dl,10
int 21h
mov dl,13
int 21h
mov ah,9
mov dx,offset str6
int 21h
mov ah,2
mov dx,consonants
int 21h
mov dl,10
int 21h
mov dl,13
int 21h
mov ah,9
mov dx,offset str7
int 21h
mov ah,2
dec symbols
mov dx,symbols
int 21h
mov dl,10
int 21h
mov dl,13
int 21h
mov ah,4ch
int 21h
main endp
end main