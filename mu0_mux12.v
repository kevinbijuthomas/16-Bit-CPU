// MU0 12 bit, 2 to 1 MUX design - behavioural style
// P W Nutter (based on a design by Jeff Pepper)
// Date 20/8/2021
//

// Do not touch the following line it is required for simulation
`timescale 1ns/100ps

// for simulation purposes, do not delete
`default_nettype none


module mu0_mux12(input  wire [11:0] A,
	             input  wire [11:0] B,
			     input  wire        S,
			     output reg  [11:0] Q);


// Combinatorial logic for 2to1 multiplexor
// S is select, A channel0, B channel1
always @ (*)
begin
	if (S == 1) Q = B;
	else if (S == 0) Q = A;
	else Q = 12'hxxx;
end
endmodule

// for simulation purposes, do not delete
`default_nettype wire
