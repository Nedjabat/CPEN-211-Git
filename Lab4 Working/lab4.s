
.globl binary_search
binary_search :

//r8 = middle index
//R0= numbers
//R1= key
//r2 = length
//r3 = start index
//r4 = endindex
//r5 =  keyindex
//r6 = numiters




MOV R3, #0  //startIndex=0
SUB R4, R2, #1 //endIndex = length-1
CMP R4, #0 //check if endIndex is negative

BLT neg
			//middleIndex = endIndex/2;
MOV R8, R4  //move end index into middle index
LSR R8, #1	//divide by 2

			//int keyIndex = -1
MOV R5, #-1

MOV R6, #1 // numIters = 1
B while


neg :
MOV R0,R5 //write to register 0 and return to main
MOV PC, LR  //if endIndex is negative return to main

while:

CMP R5, #-1 //  ( keyIndex) == -1
BEQ L1 //branch to l1
B end

L1 :
CMP R3, R4 // startIndex > endIndex
BGT neg

//else if (numbers[middleIndex] == key)

LDR R9, [R0, R8, LSL#2] // r9 = numbers[middleIndex]

CMP R9, R1 //check numbers(middle index) == key
MOVEQ R5, R8 //keyIndex = middleIndex;
			//endIndex = middleIndex-1;
SUBGT R4, R8, #1
ADDLT R3, R8, #1 //startIndex = middleIndex + 1;

//numbers[ middleIndex ] = -NumIters;
MVN R10, R6 //R10 = -NumIters
STR R10, [R0, R8, LSL#2] //numbers[ middleIndex ] = -NumIters;

//middleIndex = startIndex + (endIndex - startIndex)/2;
SUB R11, R4, R3 //endindec -startINdex
LSR R11, #1
ADD R8, R3, R11

//NumIters ++;
ADD R6, R6, #1
B while

end:
MOV R0,R5 //write to register 0 and return to main
MOV PC,LR
