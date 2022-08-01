// MU0 control design - behavioural style
// P W Nutter (based on a design by Jeff Pepper)
// Date 2/9/2020
// 

// Do not touch the following line it is required for simulation 
`timescale 1ns/100ps

// for simulation purposes, do not delete
`default_nettype none

// module definition

module mu0_control(input  wire         Clk,      // System clock
                   input  wire         Reset,    // System reset
                   input  wire  [3:0]  F,        // Bits [15:12] of the IR
                   input  wire         N,        // Negative flag
                   input  wire         Z,        // Zero flag
                   output wire          fetch,    // Used for debug
                   output wire          PC_En,    // Update PC
                   output wire          IR_En,    // Update IR
                   output wire          Acc_En,   // Update Acc
                   output wire          X_sel,    // Data Out mux(X port on ALU) 0 for Acc, 1 for PC
                   output wire          Y_sel,    // mux, Y port on ALU, 0 for Data In, 1 for Instr 
                   output wire          Addr_sel, // mux, 0 for PC, 1 for IR
                   output wire   [1:0]  M,        // ALU op, 0) Y, 1) X+Y, 2) X+1, 3) X-Y
                   output wire          Rd,       // Memory read
                   output wire          Wr,       // Memory write
                   output wire          Halted);  // MU0 stopped




wire state, not_Clk, not_state, not_Halted, t1, t2, t3, b1, b2, b3, s, not_s;
wire nF0, nF1, nF2, lda, sta, add, sub, jmp, jge, jne, j1, j2, nZ, nN;

not gate1 (fetch, state);
not gate2 (nF0, F[0]);
not gate3 (nF1, F[1]);
not gate4 (nF2, F[2]);

and gate5  (Halted, F[2], F[1], F[0], state);
and gate6  (jne, F[2], F[1], nF0, state);
and gate7  (jge, F[2], nF1, F[0], state);
and gate8  (jmp, F[2], nF1, nF0, state);
and gate9  (sub, nF2, F[1], F[0], state);
and gate10 (add, nF2, F[1], nF0, state);
and gate11 (sta, nF2, nF1, F[0], state);
and gate12 (lda, nF2, nF1, nF0, state);


buf gate13 (Y_sel, F[2]);
buf gate14 (IR_En, fetch);
buf gate15 (X_sel, fetch);
buf gate16 (Addr_sel, state);


not gate17 (nZ, Z);
not gate18 (nN, N);
and gate19 (j1, jne, nZ);
and gate20 (j2, jge, nN);
or  gate21 (PC_En, fetch, jmp, j1, j2);

or gate22 (M[1], sub, fetch);
or gate23 (M[0], add, sub);

buf gate24 (Wr, sta);

or gate25 (Rd, lda, add, sub, fetch);
or gate26 (Acc_En, lda, add, sub);
	       
not  gate27 (not_Clk, Clk);
not  gate28 (not_Halted, Halted);

or   gate29 (t1, not_state, Halted);
and  gate30 (t2, not_Clk, t1);
nor  gate31 (s, t2, not_s);
and  gate32 (t3, s, Clk);
nor  gate33 (state, t3, not_state, Reset);

or   gate34 (b1, state, not_Halted);
and  gate35 (b2, not_Clk, state);
nor  gate36 (not_s, b2, s, Reset);
and  gate37 (b3, not_s, Clk);
nor  gate38 (not_state, b3, state);


endmodule 

// for simulation purposes, do not delete
`default_nettype wire
