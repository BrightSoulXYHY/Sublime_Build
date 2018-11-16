; 冒泡法排序

DATA SEGMENT
X1  DB  '4321',0DH,0AH,'$'
COUNT   EQU $-x1-2
DATA ENDS


CODE SEGMENT
ASSUME CS:CODE,DS:DATA
MAIN PROC
        ;设置DS的正确地址
START:  MOV AX,DATA
        MOV DS,AX

        ; CX<-loop的循环次数
        MOV BX,COUNT
        MOV DX,OFFSET X1

        CALL BUBBLE

        MOV AX,4C00H
        INT 21H
MAIN ENDP



BUBBLE PROC
B_LOOP:  
        MOV CX,BX
        MOV SI,DX

        ;冒泡法排序，从大至小递减
        ;[SI]与[SI+1]比较小于则交换，否则跳过
B_CAMP: MOV AL,[SI]
        CMP [SI+1],AL
        JAE B_NON
        XCHG AL,[SI+1]
        MOV [SI],AL
B_NON:  INC SI
        LOOP    B_CAMP
        DEC BX
        JNE B_LOOP    
        
        ;9号功能显示字符串，DS:DX
        ;4CH中断返回DOS
        MOV AH,9
        INT 21H

        RET
BUBBLE ENDP


CODE    ENDS
        END START

