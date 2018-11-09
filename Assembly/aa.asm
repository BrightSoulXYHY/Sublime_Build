DATAS SEGMENT
        string DB 13,10,'Hello World!',13,10,'$'
DATAS ENDS

CODES SEGMENT
        assume CS:CODES, DS:DATAS
START:
        mov AX, DATAS
        mov DS, AX
        lea DX, string
        mov AH, 9
        int 21H

        mov AH, 4CH
        int 21H
CODES ENDS

END START