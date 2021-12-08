/* ========================= */
/*       DATA section        */
/* ========================= */
    .data
    .align 4

/* output String */
output_1:
    .ascii "Output array:\000"  

output_2:
    .ascii "%d,\000"

output_3:
    .ascii "%d\n\000"



/* ========================= */
/*       TEXT section        */
/* ========================= */
    .section .text
    .global NumSort
    .type NumSort,%function
/* ========================= */
/*    Seleciotn  section     */
/* ========================= */
NumSort:
    /* function start */
    MOV ip, sp
    STMFD sp!, {r0-r9, fp, ip, lr, pc}
    SUB fp, ip, #4
    /* --- begin your function --- */
    /* Get array address from r10 */
    LDR r0, [ip], #4
    /* Get array size from r9 */
    LDR r1, [ip], #4
	
    MOV r10, r0
    MOV r9, r1

    MOV r0, r9, LSL #2
    bl malloc
    MOV r8, r0

    MOV r2, #0
	MOV r4, #0
	MOV r5, #0
LOOP:
    /* copy arrA to arrB*/ 
    CMP r5, r9
    BGE EXIT0
    LDR r7,[r10,r2,LSL#2]
    ADD r2, #1
    STR r7,[r8,r4,LSL#2]
    ADD r4, #1
    ADD r5, r5, #1
    B LOOP
    
EXIT0:
    /* r0 contains the address of array */
    MOV r0, r8
    /* r1 contains the first element    */
    MOV r1, #0 
    /* r2 contains the number of element */
    MOV r2, r9

    MOV r3,r1                                              @ start index i
    SUB r7,r2,#1                                           @ compute n - 1
LOOP1:                                                      @ start loop
    MOV r4,r3
    ADD r5,r3,#1                                           @ init index 2
LOOP2: 
    LDR r1,[r0,r4,LSL #2]                                  @ load value A[mini]
    LDR r6,[r0,r5,LSL #2]                                  @ load value A[j]
    CMP r6,r1                                              @ compare value
    MOVLT r4,r5                                            @ j -> mini
    ADD r5,#1                                              @ increment index j
    CMP r5,r2                                              @ end ?
    BLT LOOP2                                              @ no -> loop
    CMP r4,r3                                              @ mini <> j ?
    BEQ LOOP3                                              @ no
    LDR r1,[r0,r4,LSL #2]                                  @ yes store A[mini] to B[i]
    LDR r6,[r0,r3,LSL #2]
    STR r1,[r0,r3,LSL #2]
    STR r6,[r0,r4,LSL #2]
LOOP3:
    ADD r3,#1                                              @ increment i
    CMP r3,r7                                              @ end ?
    BLT LOOP1                                              @ no -> loop 
EXIT:
    LDR r0, =output_1
    bl printf
    MOV r5, #0
    SUB r4, r9, #1
LOOP4:
    CMP r5, r4
    BGE EXIT1
    LDR r0, =output_2
    LDR r1,[r8,r5,LSL#2]
    bl printf
    ADD r5, r5, #1
    B LOOP4

EXIT1:
    LDR r0, =output_3
    LDR r1,[r8,r5,LSL#2]
    bl printf

    /* put result array’s address into r0 */ 
    MOV r0, r8 
    /* --- end of your function --- */
    nop
    /* function exit */
    LDMFD sp!, {r0-r9, fp, ip, pc}
.end