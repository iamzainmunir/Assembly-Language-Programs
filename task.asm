.model small
.stack 100h
.386
.data
main_str db "I own UBIT$"
s1 db "Spaces = $"
s2 db "Digits = $"
s3 db "Vowels = $"
s4 db "Consonants = $"
spc dw 0,$
dig dw 0,$
vow dw 0,$
cons dw 0,$
.code
main proc
mov ax,@data
mov ds,ax
mov bx,0
mov ah,2
mov dl,10
int 21h
mov dl,13
int 21h
mov ah,9
mov dx,offset main_str
int 21h
mov ah,2
mov dl,10
int 21h
mov dl,13
int 21h
mov cl,lengthof main_str
mov di,0
l1:
cmp main_str[di],32
je inc_spc
jg chk1
inc_spc:
inc bx
add spc,bx
mov bx,0
jmp exit
chk1:
cmp main_str[di],48
jl exit
cmp main_str[di],57
jle inc_dig
jg chk3
inc_dig:
inc bx
add dig,bx
mov bx,0
jmp exit
chk3:
cmp main_str[di],65
jl exit
cmp main_str[di],90
jle inc_alpha
jg chk5
inc_alpha:
cmp main_str[di],65
je inc_vow
cmp main_str[di],69
je inc_vow
cmp main_str[di],73
je inc_vow
cmp main_str[di],79
je inc_vow
cmp main_str[di],85
je inc_vow
jmp inc_cons
inc_vow:
inc bx
add vow,bx
mov bx,0
jmp exit
chk5:
cmp main_str[di],96
jle exit
jg chk6
inc_cons:
inc bx
add cons,bx
mov bx,0
jmp exit
chk6:
cmp main_str[di],122
jg exit
cmp main_str[di],97
je inc_vow
cmp main_str[di],101
je inc_vow
cmp main_str[di],105
je inc_vow
cmp main_str[di],111
je inc_vow
cmp main_str[di],117
je inc_vow
jmp inc_cons
exit:
inc di
dec cl
jne l1
add vow,48
add cons,48
add spc,48
add dig,48
mov ah,9
mov dx,offset s1
int 21h
mov ah,2
mov dx,spc
int 21h
mov dl,10
int 21h
mov dl,13
int 21h
mov ah,9
mov dx,offset s2
int 21h
mov ah,2
mov dx,dig
int 21h
mov dl,10
int 21h
mov dl,13
int 21h
mov ah,9
mov dx,offset s3
int 21h
mov ah,2
mov dx,vow
int 21h
mov dl,10
int 21h
mov dl,13
int 21h
mov ah,9
mov dx,offset s4
int 21h
mov ah,2
mov dx,cons
int 21h
mov dl,10
int 21h
mov dl,13
int 21h
mov ah,4ch
int 21h
main endp
end main