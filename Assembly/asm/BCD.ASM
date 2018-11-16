DATA SEGMENT
STR_IN  DB  'Please input a character:',0DH,0AH,'$'
STR_ED  DB  0DH,0AH,'Ended!',0DH,0AH,'$'
STR_X1   DB  4 DUP(0)
STR_X2   DB  4 DUP(0)
STR_X3   DB  5 DUP(0)
STR_CR  DB      0AH,0DH,'$'
DATA ENDS

STACK SEGMENT STACK
STAPN DB 20 DUP(?)
TOP EQU LENGTH STAPN
STACK ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA,SS:STACK
MAIN PROC FAR
START:
        PUSH DS
        XOR AX,AX
        PUSH AX
        MOV AX,DATA
        MOV DS,AX

        ;��ʾ��ʾ�ַ�
        LEA DX,STR_IN
        MOV AH,09H
        INT 21H

        ; ����4������
        MOV CX,4
        MOV DX,OFFSET STR_X1
        CALL KEYIN
        
        MOV DL,'+'
        MOV AH,02H
        INT 21H
        
        ; ����4������
        MOV CX,4
        MOV DX,OFFSET STR_X2
        CALL KEYIN
        
        MOV DL,'='
        MOV AH,02H
        INT 21H
        
        MOV CX,4
        MOV DI,OFFSET STR_X1
        MOV SI,OFFSET STR_X2
        MOV BX,3

        CLC
        ; ����ASC������ӣ�ʹ��AAAָ������õ�BCD��
        ; �ӵ�λ��ʼ����ջ
B_ADD:  MOV AL,[SI+BX]
        ADC AL,[DI+BX]
        AAA
        PUSH AX
        DEC BX
        LOOP B_ADD


        MOV SI,OFFSET STR_X3
        MOV BL,' '
        MOV [SI],BL
        ; ��û�н�λ����ʾ
        MOV AL,0
        ADC AL,0
        CMP AL,0
        JE N_CAR
        
        ; �н�λ����ʾ�������ݶα���
        ADD AL,30H
        MOV [SI],AL
        MOV DL,AL
        MOV AH,02H
        INT 21H

N_CAR:  MOV CX,4


B_OUT:  MOV BX,CX
        POP AX
        ADD AL,30H
        MOV DL,AL
        MOV [BX+SI],AL
        MOV AH,02H
        INT 21H
        LOOP B_OUT
        

        MOV DX,OFFSET STR_CR
        MOV AH,09H
        INT 21H

        MOV DL,' '
        MOV AH,02H
        INT 21H


        MOV CX,4
        MOV BX,3
        MOV SI,OFFSET STR_X1
COL1:   MOV DL,[SI+BX]
        MOV AH,02H
        INT 21H
        DEC BX
        LOOP COL1

        MOV DX,OFFSET STR_CR
        MOV AH,09H
        INT 21H

        MOV DL,'+'
        MOV AH,02H
        INT 21H

        MOV DI,OFFSET STR_X2
        MOV CX,4
        MOV BX,3
COL2:   MOV DL,[DI+BX]
        MOV AH,02H
        INT 21H
        DEC BX
        LOOP COL2

        MOV DX,OFFSET STR_CR
        MOV AH,09H
        INT 21H


        MOV DI,OFFSET STR_X3
        MOV DL,[DI]
        MOV AH,02H
        INT 21H

        MOV CX,4
        MOV BX,4
COL3:   MOV DL,[DI+BX]
        MOV AH,02H
        INT 21H
        DEC BX
        LOOP COL3

        


        RET
MAIN ENDP

; ����һ���ַ�����DS,SIΪ�ַ�������ĩ�����س������
KEYIN   PROC
        MOV SI,DX
      
        ;����4�����ַ���
INPUT:  
        MOV AH,08H
        INT 21H
        CMP AL,30H
        JB  INPUT
        CMP AL,39H
        JA  INPUT

        ; ����DATA�����
        MOV DL,AL
        MOV AH,02H
        INT 21H


        MOV [SI],AL
        INC SI
        LOOP INPUT

        RET
KEYIN   ENDP


CODE    ENDS
        END MAIN