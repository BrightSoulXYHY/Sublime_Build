; ��ʾ��������,GBK
DATA SEGMENT
X   DB  0FAH;0000 1010 0000 1010
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
MAIN PROC FAR
        ;PSP��DS:00��ջ���棬���ڳ��򷵻�
START:  PUSH DS
        XOR AX,AX
        PUSH AX
        MOV AX,DATA
        MOV DS,AX

        ;ѭ��������CF��2�Ź�����ʾDL�е�ASCII��
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




