/* ========================= */
/*       DATA section        */
/* ========================= */
	.data
    .align 4

/* --- variable a --- */
	.type a, %object
	.size a, 400    @ max size is 100.
a:
	.word 1
	.word 10
	.word 6
	.word 3
	.word 20
	.word 40
	.word 9
    .word 11

/* Input String */
input_1:
    .ascii "Input array:\000"  

input_2:
    .ascii "%d,\000"

input_3:
    .ascii "%d\n\000"


/* ========================= */
/*       TEXT section        */
/* ========================= */
    .section .text
    .global main
    .type main,%function

.array:
    .word a
main:
    MOV ip, sp
    STMFD sp!, {fp, ip, lr, pc}
    SUB fp, ip, #4
    
    /* prepare input array */
    MOV r0, #8
    LDR r1, .array

    /* put array size into sp */
    STR r0, [sp, #-4]!
    /* put array address into sp */
    STR r1, [sp, #-4]!

    MOV r10, r0
    MOV r9, r1

    LDR r0, =input_1
    bl printf
    MOV r5, #0
    SUB r4, r10, #1
LOOP:
    CMP r5, r4
    BGE EXIT
    LDR r0, =input_2
    LDR r1,[r9,r5,LSL#2]
    bl printf
    ADD r5, r5, #1
    B LOOP
EXIT:
    LDR r0, =input_3
    LDR r1,[r9,r5,LSL#2]
    bl printf
    bl NumSort
    /* --- end of your function --- */
    LDMEA fp, {fp, sp, pc}
    .end