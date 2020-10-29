*-----------------------------------------------------------
* Title      :HomeworckChecker
* Written by :Steven & Friends
* Date       :10/25/2020
* Description: A program to perform an operation on hex values given by user.
* The programs returns the new hex number after the operation as well as any flags
* That were set off
*
* ##!!MESSAGES IN CAPS ARE IMPORTANT!!!!!!!!!!#####
*
* Currently, initial hex data and the operation are hard coded. Extended is just connected
* to carry.... needs fixing

* ##!!!TO USE: Hardcode your hex value into data, and hardcode the operation
* in the 4 spots under labels, OVFL,CAR,NEG,ZER
*-----------------------------------------------------------
    
CR       EQU     $0D            *Carriage return
LF       EQU     $0A            *Line feed
data     EQU     $3456ABCF      * !!!PUT YOUR HEXDECIMAL VALUE HERE !!!!


         ORG    $1000
START:                 
LOOP
    LEA         GREET,A1        *Loads greeting message CANNOT ENTER INPUT ATM MUST HARDCODE
    MOVE.B      #14,D0
    TRAP        #15
    MOVE        #0,D3           *Move 0 into D3 for a FOR loop
    
    
*INLOOP
 *   ADD.W       #1,D3
 *   CMP.W       #8,D3
 *  BGT         COMP
 *   MOVE.B      #5,D0         *Move 4 to data register 0 for trap task
 *   TRAP        #15             *Trap task reads from input and puts input data into D1.L
 *   MOVE.L      D1,D4
 *   ASL.B       #1,D4       
 *   BRA         INLOOP
    
    
*-----Conversion Methods-------
ASC2HEX
    
    

ALPHA

ERROR
*----Computations----
COMP
    LEA         GREET2,A1       *Loads second greeting message/rules/Notes
    MOVE.B      #14,D1
    TRAP        #15
    

OVFL
    MOVE        #$00,CCR
    MOVE.L      #data,D1        *Moves data(your hex value) into D1 for trap task
     ASR.W #3,D1         *##!!!HARDCODE YOUR OPERATION HERE!!!!!CHANGE TO D1!!! performs your operation!!!!!!###
    BVS         OVER            *Branches if overflow flag is set   
    
    
CAR
    MOVE        #$00,CCR
    MOVE.L      #data,D1         
     ASR.W #3,D1          *##!!!HARDCODE YOUR OPERATION HERE!!!!CHANGE TO D1!!! performs your operation!!!!!!###
    BCS         CARRY           *Branches if carry flag is set
    
    
NEG
    MOVE        #$00,CCR
    MOVE.L      #data,D1         
     ASR.W #3,D1           *##!!!HARDCODE YOUR OPERATION HERE!!!!CHANGE TO D1!!! performs your operation!!!!!!###
    CMP.L       #0,D1
    BLT         NEGA            *Branches if negative flag is set
     
    
ZER 
    MOVE        #$00,CCR
    MOVE.L      #data,D1
     ASR.W #3,D1       *##!!!HARDCODE YOUR OPERATION HERE!!!!CHANGE TO D1!!! performs your operation!!!!!!###
    CMP.L       #0,D1  
    BEQ         ZERO           *Branches if Zerp flag is set
    
    
RESULT  
                                  *returns number stored in D1, should be hex result.
    MOVE.B      #15,D0     
    MOVE.B      #16,D2
    TRAP        #15
    BRA         DONE


*-------MESSAGES---------------

CARRY                        *Displays message if carry flag is set, branches back to NEG to continue
    LEA         CAROUT,A1           
    MOVE.B      #14,D0
    TRAP        #15
    BRA         NEG
    
       
OVER                         *Displays message if overflow flag is set, branches back to NEG to continue
    LEA         OVROUT,A1
    MOVE.B      #14,D0
    TRAP        #15
    BRA         CAR
    

NEGA                         *Displays message if negative flag is set, branches back to NEG to continue
    LEA         NEGOUT,A1
    MOVE.B      #14,D0
    TRAP        #15
    BRA         ZER
    
    
ZERO                         *Displays message if zero flag is set, branches back to NEG to continue
    LEA         ZEROUT,A1
    MOVE.B      #14,D0
    TRAP        #15
    BRA         RESULT
    
    
DONE
     MOVE.B     #9,D0
     TRAP       #15                 Halt Simulator

   

GREET     DC.B    CR,LF,'Enter your hex value to perform Operation and Flag Check.',CR,LF,0 
GREET2    DC.B    CR,LF,'*000XNZVC* ROL operation ignores X and V is always 0',CR,LF,0 
CAROUT    DC.B    CR,LF,'CARRY FLAG SET (C). EXTENDED FLAG SET (X)',CR,LF,0 
OVROUT    DC.B    LF,CR,LF,'OVERFLOW FLAG SET (V).',CR,LF,0
NEGOUT    DC.B    'NEGATIVE FLAG SET (N).',CR,LF,0
ZEROUT    DC.B    'ZERO FLAG SET (Z).',CR,LF,CR,LF,0




    END    START        ; last line of source







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
