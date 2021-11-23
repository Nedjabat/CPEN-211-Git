.global _start
_start:
 MOV R0, #2 // n=2
 LDR R1, =input // base of A = first address of array “input”
 LDR R2, =output// base of B = first address of array “output”
 MOV R3, #0
 MOV R4, #1
BL loopy
END: B END // infinite loop; R0 should contain return value of loopy
.global loopy
loopy:
MOV R5, #0    //int L1norm=0;
MOV R6, #0    //int i=0;
CMP R0, R6    
BGT while   //while( i < n ) {

while:    
LDR R7, [R1, R6, LSL#2]    //int tmp = A[i];
CMP R3, R7   //if( tmp < 0 ) {
SUBGT R7, R3, R7 //tmp = -tmp;}
//MVNGT R7,R7    
STR R7, [R2,R6,LSL#2]  //B[i] = tmp;
ADD R5, R5, R7    //L1norm = L1norm + tmp;
ADD R6, R6, #1    //i = i + 1;}
CMP R0,R6
BGT while
MOV R0, R5    //return L1norm;
MOV PC, LR
input:
 .word -1
 .word 1
output:
 .word 0
 .word 0