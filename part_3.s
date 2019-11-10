/******************************************************************************
* file: code-conversion_part_3.s
* author: Venkatesh Ravipati
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/
@ BSS section
.bss

@ DATA SECTION
.data
input:
BCDNUM: .word 0x92529679

Output:                     
NUMBER: .word     0x0;		//Output variable to store NUMBER value

DATA:
MULTP: .word 1,10,100,1000,10000,100000,1000000,10000000
@ TEXT section
.text

.globl _main

/* i = BCDNUM
	while i == 0
	{
		x = i & 0xf
		i = i >> 4
		output = x * 10 multiples
	}

*/
_main:
	LDR r0, =BCDNUM; 	//loading STRING address to r1
	LDR r4, =MULTP
	LDR r1, [r0];
	MOV r3, #0
	MOV r6, #0
LOOP:
	CMP r1,#0
	BEQ UPD
	MOV r7,#0
	AND r2,r1,#0xf
	LSR r1, #4
	LDR r5, [r4],#4
REP:
	CMP r2, r7
	BEQ LOOP
	ADD r3, r3, r5
	ADD r7, r7, #1
	B REP
UPD:
	LDR r0, =NUMBER
	STR r3, [r0]
	
END: NOP
.end
