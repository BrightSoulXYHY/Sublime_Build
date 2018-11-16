; 显示二进制数,GBK
DATA SEGMENT
X   DB  0FAH;0000 1010 0000 1010
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
MAIN PROC FAR
        ;PSP的DS:00入栈保存，便于程序返回
START:  PUSH DS
        XOR AX,AX
        PUSH AX
        MOV AX,DATA
        MOV DS,AX

        ;循环左移至CF，2号功能显示DL中的ASCII码
        MOV CX,8
NEXT:   XOR DL,DL
        ROL X,1
        ADC DL,30H
        MOV AH,2
        INT 21H
        LOOP NEXT
        RET
MAIN    ENDP
CODE    ENDS
        END MAIN




