/******************************************************************************
* file: code-conversion_part_2.s
* author: Venkatesh Ravipati
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/
@ BSS section
.bss

@ DATA SECTION
.data
input:
STRING: .byte 0x31, 0x31, 0x30, 0x31, 0x30, 0x30,0x31,0x30;

Output:                     
NUMBER: .word     0x0;		//Output variable to store NUMBER value
ERROR:  .byte 0x0;  
@ TEXT section
.text

.globl _main

/* for i from 0 to 7
	x -> [r0 +  i]
	if  x == 0x31
		value lsl by 1
		value = value or 0x1
	if  x == 0x30
		value lsl by 1
		value = value or 0x0
	else
		error
		store 0xff to ERROR
	
	store value to NUMBER

*/
_main:
	LDR r0, =STRING; 	//loading STRING address to r1
	MOV r1, #0;
	MOV r3, #0;
LOOP:
	CMP r1, #0x8
	BEQ UPD
	LDRB r2, [r0,r1]
	CMP r2, #0x30
	BEQ ZERO
	CMP r2, #0x31
	BEQ ONE
	B ERR
ZERO:
	LSL r3,#1
	ORR r3,#0;
	ADD r1,r1,#1
	B LOOP
ONE:
	LSL r3,#1
	ORR r3, #1
	ADD r1,r1,#1
	B LOOP
UPD:
	LDR r0, =NUMBER
	STR r3, [r0]
	B END
ERR:
	LDR r0, =ERROR
	MOV r1,#0xff
	STRB r1, [r0]
END: NOP
.end
