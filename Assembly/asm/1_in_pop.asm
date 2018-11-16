;键盘输入数据
DATA SEGMENT
STR_IN  DB  'Please input characters:',0DH,0AH,'$'
STR_ED  DB  0DH,0AH,'Input ended!',0DH,0AH,'$'
STR_X   DB  100 DUP(?)
COUNT   DW  0
; STR_X  DB  '4321',0DH,0AH,'$'
; COUNT   DW  3

DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
MAIN    PROC FAR
START:  
        PUSH DS
        XOR AX,AX
        PUSH AX
        MOV AX,DATA
        MOV DS,AX

        ; 输入字符串至DS储存
        CALL KEYIN


        ; MOV DX,OFFSET STR_X
        ; MOV AH,09H
        ; INT 21H

        LEA DX,STR_X-1
        MOV BX,COUNT
        CALL BUBBLE


        MOV DX,OFFSET STR_X
        MOV AH,09H
        INT 21H

      

        RET
MAIN    ENDP

; 输入一串字符存入DS,SI为字符串的最末，若回车则结束
KEYIN   PROC
        MOV SI,OFFSET STR_X
        ;显示提示字符
        LEA DX,STR_IN
        MOV AH,09H
        INT 21H
        
;输入为回车退出
INPUT:  
        MOV AH,08H
        INT 21H
        CMP AL,0DH
        JE  UNVLB

        ; 否则存入DATA并输出
        MOV [SI],AL
        INC SI
        INC COUNT
        MOV DL,AL
        MOV AH,02H
        INT 21H
        JMP INPUT

UNVLB:  
        MOV AL,'$'
        MOV [SI],AL
        MOV DL,OFFSET STR_ED
        MOV AH,09H
        INT 21H
K_EXIT: RET
KEYIN   ENDP

; 冒泡排序，升序排列,从最下开始，将最小的浮上来
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
BUBBLE  ENDP

CODE    ENDS
        END MAIN




