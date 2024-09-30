.model small
.stack 100H
.data
	a DW ?
	c DW ?
	d DW ?
	t1 DW ?
	t2 DW ?
	t3 DW ?
	t4 DW ?
.code


main PROC
	MOV AX, a
	MOV AX, c
	MOV AX, c
	MOV BX, 2
	MUL BX
	MOV t1, AX
	MOV AX, t1
	MOV BX, 12
	SUB AX, BX
	MOV t2, AX
	MOV AX, a
	MOV BX, t2
	ADD AX, BX
	MOV t3, AX
	MOV AX, a
	MOV AX, c
	MOV AX, a
	MOV BX, c
	SUB AX, BX
	MOV t1, AX
	MOV AX, 2
	MOV BX, 3
	SUB AX, BX
	MOV t2, AX
	MOV AX, t2
	MOV AX, t2
	MOV BX, 5
	MUL BX
	MOV t3, AX
	MOV AX, t1
	MOV BX, t3
	SUB AX, BX
	MOV t4, AX
main ENDP
END main
