;������������
DATA SEGMENT
X1  DB  'Please input a character:',0DH,0AH,'$'
X2  DB  'The character is unavalible!',0DH,0AH,'$'
X3  DB  'OK!',0DH,0AH,'$'
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
MAIN    PROC FAR
START:  PUSH DS
        XOR AX,AX
        PUSH AX
        MOV AX,DATA
        MOV DS,AX

        CALL KEYIN
        
        ; ��ʾ������ַ�
        MOV DL,AL
        MOV AH,02H
        INT 21H

        RET
MAIN    ENDP

KEYIN   PROC
        ;��ʾ��ʾ�ַ�
INPUT:  LEA DX,X1
        MOV AH,09H
        INT 21H
        
        ;���벢�жϣ������������������������
        MOV AH,08H
        INT 21H
        CMP AL,30H
        JB  UNVLB
        CMP AL,39H
        JA  UNVLB
        ; ���������������ʾ�ַ�������
        LEA DX,X3
        MOV AH,09H
        INT 21H
        JMP K_EXIT

        ; �����ʾ�ַ�������������
UNVLB:  LEA DX,X2
        MOV AH,09H
        INT 21H
        JMP INPUT
K_EXIT: RET
KEYIN   ENDP

CODE    ENDS
        END MAIN


