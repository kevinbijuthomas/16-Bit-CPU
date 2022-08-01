// MU0 ALU design 
// P W Nutter (based on a design by Jeff Pepper)
// Date 2/9/2020
// 

// Do not touch the following line it is required for simulation 
`timescale 1ns/100ps

// for simulation purposes, do not delete
`default_nettype none

// module header

module mu0_alu(input  wire [15:0]  X, 
               input  wire [15:0]  Y, 
               input  wire [1:0]   M, 
               output wire  [15:0]  Q);

// gate level description
wire [15:0] a, b, axorb, ab, cin_axorb, cout;
wire [1:0] not_M;
wire Xone_two_three;
wire [15:0] not_Y, Yzero_one, Ythree;



not  gate1 [1:0] (not_M, M);


or   gate2        (Xone_two_three, M[1], M[0]);
and  gate3 [15:0] (a, Xone_two_three, X);


not gate4 [15:0] (not_Y, Y);
and gate5 [15:0] (Yzero_one, not_M[1], Y);
and gate6 [15:0] (Ythree, M[1], M[0], not_Y);
or  gate7 [15:0] (b, Yzero_one, Ythree);

xor gate8 [15:0] (axorb, a, b);    
xor gate9 [15:0] (Q, {cout[14:0], M[1]}, axorb);
and gate10 [15:0] (ab, a, b);
and gate11 [15:0] (cin_axorb,  {cout[14:0], M[1]}, axorb); 
or  gate12 [15:0] (cout, cin_axorb, ab);


endmodule 

// for simulation purposes, do not delete
`default_nettype wire
