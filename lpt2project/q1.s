.global _start
_start:
 MOV R0, #1 // i=1
 MOV R1, #2 // j=2
 MOV R2, #1 // k=1
 MOV R4, #1
 MOV R5, #2
 MOV R6, #3
 MOV R7, #4
 MOV R8, #0
 LDR R3, =data // set base of A = first address of array “data”
BL func
END: B END // infinite loop; R0 should contain return value of func
.global func
func://int func(int i, int j, int k, int *A) {

CMP R1, R0  //if( i < j ) {  
STRGT R4, [R3,R8,LSL#2]   //A[0] = 1;//}
CMP R0, R2 //if( i == k ) {
BEQ first 
ADD R0,R1,R0//return i+j;
MOV PC,LR

first: 
 STR R5, [R3,R4,LSL#2] //A[1] = 2;
 LDR R9, [R3,R5, LSL#2]
 CMP R9,R2//if( A[2] > j ) { 
 STRGT R7, [R3,R6,LSL#2]   //A[3] = 4;
 
 ADD R0,R1,R0//return i+j;
 MOV PC,LR

data:
 .word 0
 .word 0
 .word 3
 .word 0    