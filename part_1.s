/******************************************************************************
* file: code-conversion_part_1.s
* author: Venkatesh Ravipati
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/
@ BSS section
.bss

@ DATA SECTION
.data
input:
A_DIGIT: .byte 'H';
Reserved: .byte 0x0,0x0,0x0
Output:                     
H_DIGIT: .word     0x0;		//Output variable to store H_DIGIT value

@ TEXT section
.text

.globl _main

/* if a => 0x30 and a <=0x39
	value = a & 0xF --> 0 to 9
   else if a => 0x41 and a <=0x46
	value = a & 0xF + 0x9 --> 0xA to 0xF 
   else if a => 0x61 and a <=0x66
	value = a & 0xF + 0x9 --> 0xA to 0xF
	else
	 value = 0xffffffff
	 H_DIGIT = value
*/
_main:
	LDR r1, =A_DIGIT; 	//loading A_DIGIT address to r1
	LDRB r2, [r1];       //loading A_DIGIT value to r2
	LDR r1, =H_DIGIT;    //load H_DIGIT address to r1
	AND r3, r2, #0xF0;
	CMP r3, #0x30
	BEQ NUM
	CMP r3, #0x40
	BEQ CHAR
	CMP r3, #0x60
	BEQ CHAR
	B ERR
NUM:AND r3, r2, #0xF
	STR r3, [r1]
	B END
CHAR: AND r3, r2, #0xF
	CMP r3, #0x7
	BGT ERR;
	ADD r3, r3, #0x9
	STR r3, [r1]
	B END
ERR: MOV r3, #0xffffffff
	 STR r3, [r1]
END: NOP
.end
