; ð�ݷ�����

DATA SEGMENT
X1  DB  '4321',0DH,0AH,'$'
COUNT   EQU $-x1-2
DATA ENDS


CODE SEGMENT
ASSUME CS:CODE,DS:DATA
MAIN PROC
        ;����DS����ȷ��ַ
START:  MOV AX,DATA
        MOV DS,AX

        ; CX<-loop��ѭ������
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

        ;ð�ݷ����򣬴Ӵ���С�ݼ�
        ;[SI]��[SI+1]�Ƚ�С���򽻻�����������
B_CAMP: MOV AL,[SI]
        CMP [SI+1],AL
        JAE B_NON
        XCHG AL,[SI+1]
        MOV [SI],AL
B_NON:  INC SI
        LOOP    B_CAMP
        DEC BX
        JNE B_LOOP    
        
        ;9�Ź�����ʾ�ַ�����DS:DX
        ;4CH�жϷ���DOS
        MOV AH,9
        INT 21H

        RET
BUBBLE ENDP


CODE    ENDS
        END START

