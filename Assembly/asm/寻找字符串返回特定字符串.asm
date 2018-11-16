; 寻找字符串返回特定字符串

; 09H功能显示以'$'结尾的字符串
; 01H功能等待键盘输入，并将输入的字符送至AL
; LOOP一次CX递减1
; 4CH功能返回DOS不用定义PROC

STACK   SEGMENT STACK
DB  100 DUP (?)
STACK   ENDS

DATA    SEGMENT
X1  DB  100 DUP (?)
TXT DB  'Please input a character:$'
FD  DB  0DH,0AH,'Found!',0DH,0AH,'$'
NF  DB  0DH,0AH,'Not Found!',0DH,0AH,'$'
DATA    ENDS

CODE    SEGMENT
ASSUME  SS:STACK,DS:DATA,CS:CODE

        ;设置DS的正确地址
START:  MOV AX,DATA
        MOV DS,AX
        
        ;调用9号功能显示字符串，DS:DX
        MOV DX,OFFSET TXT
        MOV AH,9
        INT 21H

        ;调用1号功能输入字符至AL
        MOV AH,1
        INT 21H

        MOV SI,OFFSET X1
        ;循环次数100送入CX,SI为X1的偏移地址
        MOV CX,100
        ;比较若相同则跳转至FOUND
NEXT:   CMP AL,[SI]
        JE  FOUND
        INC SI
        LOOP    NEXT
        
        ;调用9号功能显示字符串，DS:DX
        MOV DX,OFFSET NF
        MOV AH,9
        INT 21H
        JMP EXIT
        
        
        ;调用9号功能显示字符串，DS:DX
FOUND:  MOV DX,OFFSET FD
        MOV AH,9
        INT 21H
        
EXIT:   MOV AX,4C00H
        INT 21H
CODE    ENDS
        END START

