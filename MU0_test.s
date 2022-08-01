;	Simple MU0 verification programme
;	JDG
;	November 2008
;	Modified Jan 2012 by JSP

;       Begin program at reset address. Acc, pc, and ir should all be 0 after reset
        ORG  0

;       Test store to memory 
	STA  result1	 ; Store acc into memory loc result1. result1 = 0

;       Test load accumulator from memory
        LDA  neg         ; Acc should be set to 'h8000
	STA  result2	 ; Store value of acc to memory. result2 = 'h8000

;       Simple adder overflow test
	ADD neg          ; Acc should overflow to 0 ('h8000 + 'h8000)
	STA  result3	 ; Store the addition result to memory. result3 = 0

;       Simple subtraction test
	SUB one		 ; Acc should be 'hFFFF(0 - 1 = -1) 
	STA  result4	 ; Store the subtraction result to memory. result4 = 'hFFFF       

;       Test unconditional jump(JMP) - (always jump)
;       If JMP passes result5 = 'h1A55, else result5 = 'hFA01
	JMP  jmp1ok      ; Pc should be set to jmp1ok
        LDA  jmperr1     ; If jump fails load error value
	STA  result5	 ; If jump fails set memory to failure value.


;       Test conditional jump(JNE) based on the Z(zero) flag
;       Relies on the JMP instr already being tested and working

;       Test JNE for when Z flag is NOT set
;       If JNE jumps when it should result6 = 'h1A55, else result6 = 'hFA02
jmp1ok  LDA  one	 ; (Z)zero flag not set 
        JNE  jmp2ok      ; Jump SHOULD be taken and execute the "pass" reporting code
;       error reporting code
        LDA  jmperr2     ; If JNE failed load the acc with error value
	STA  result6	 ; If JNE failed set memory to failure value. result6 = 'hFA02
        JMP  fail1       ; If JNE failed, then jump over the "pass" reporting code
;       pass reporting code
jmp2ok  LDA  pass1       ; If jump taken load the acc with the pass value
	STA  result6     ; If jump taken set memory to pass value. result6 = 'h1A55

;       If JNE jumps when it should NOT result7 = 'hFA03, else result7 = 'h1A55
;       Test JNE for when Z flag is set
fail1	LDA  zero	 ; (Z)zero flag set 
        JNE  fail2       ; If JNE jumps here, it shouldn't have, execute error reporting code
        JMP  jmp3ok      ; If JNE was ok, then execute the "pass" reporting code 
;       error reporting code 
fail2   LDA  jmperr3     ; If JNE jumped when it should not have, then load error value
	STA  result7	 ; If JNE fails set memory loc to failure value. result7 = 'hFA03
        JMP  stop        ; If JNE failed, then jump over the "pass" reporting code 
;       pass reporting code
jmp3ok  LDA  pass1       ; Load the acc with the pass value
	STA  result7     ; Set memory to pass value. result6 = 'h1A55
;       End of test for conditional jump(JNE) based on the Z(zero) flag


stop    STP              ; STOP - HALT program
done    JMP done         ; Just in case stop instr fails

one     DEFW 1           ; one
neg     DEFW &8000       ; -max
zero    DEFW &0000       ; zero

jmperr1	DEFW &FA01       ; jump fail values
jmperr2	DEFW &FA02
jmperr3	DEFW &FA03

pass1   DEFW &1A55	 ; jump pass value

;       result storage area
result1	DEFW &FFFF
result2 DEFW &0000
result3	DEFW &FFFF
result4 DEFW &0000
result5 DEFW &1A55
result6 DEFW &0000
result7 DEFW &0000

