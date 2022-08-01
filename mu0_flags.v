// MU0 flags design - behavioural style
// P W Nutter (based on a design by Jeff Pepper)
// Date 20/8/2021
// 

// Do not touch the following line it is required for simulation 
`timescale 1ns/100ps

// for simulation purposes, do not delete
`default_nettype none

// module definition

module mu0_flags(input  wire [15:0]  Acc, 
	             output reg          N, 
				 output reg          Z);

// Combinatorial logic

always @(*)
 begin
   Z = ~|Acc;     // When Acc equals 0, Zero flag is set
   N = Acc[15];   // When negative bit of Acc is set, Negative flag is set
 end

endmodule 

// for simulation purposes, do not delete
`default_nettype wire
