; Ѱ���ַ��������ض��ַ���

; 09H������ʾ��'$'��β���ַ���
; 01H���ܵȴ��������룬����������ַ�����AL
; LOOPһ��CX�ݼ�1
; 4CH���ܷ���DOS���ö���PROC

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

        ;����DS����ȷ��ַ
START:  MOV AX,DATA
        MOV DS,AX
        
        ;����9�Ź�����ʾ�ַ�����DS:DX
        MOV DX,OFFSET TXT
        MOV AH,9
        INT 21H

        ;����1�Ź��������ַ���AL
        MOV AH,1
        INT 21H

        MOV SI,OFFSET X1
        ;ѭ������100����CX,SIΪX1��ƫ�Ƶ�ַ
        MOV CX,100
        ;�Ƚ�����ͬ����ת��FOUND
NEXT:   CMP AL,[SI]
        JE  FOUND
        INC SI
        LOOP    NEXT
        
        ;����9�Ź�����ʾ�ַ�����DS:DX
        MOV DX,OFFSET NF
        MOV AH,9
        INT 21H
        JMP EXIT
        
        
        ;����9�Ź�����ʾ�ַ�����DS:DX
FOUND:  MOV DX,OFFSET FD
        MOV AH,9
        INT 21H
        
EXIT:   MOV AX,4C00H
        INT 21H
CODE    ENDS
        END START

