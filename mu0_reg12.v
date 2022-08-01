// MU0 12 bit register design - behavioural style
// P W Nutter (based on a design by Jeff Pepper)
// Date 20/8/2021
//

// Do not touch the following line it is required for simulation
`timescale 1ns/100ps

// for simulation purposes, do not delete
`default_nettype none

// module header
module mu0_reg12(input  wire        Clk,
	             input  wire        Reset,
			     input  wire        En,
			     input  wire [11:0] D,
			     output reg  [11:0] Q);

// behavioural code - clock driven
always @ (posedge Clk, posedge Reset)
begin
    case(Reset)
		1'b1: Q <= 12'h000; //if reset high, clear reg
		1'b0: if (En)
			 Q <= D;
		      else Q <= Q;
		default: Q <= 12'h000;
    endcase
end
endmodule

// for simulation purposes, do not delete
`default_nettype wire
