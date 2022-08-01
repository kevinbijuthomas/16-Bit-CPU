// MU0 memory
// P W Nutter (based on a design by Jeff Pepper)
// Date 20/8/2021

// Single port memory module
// Address range 0 to 12'hEFF is memory/ram
// Uses a Synchronous RAM on a negedge clock, to fool processor into think its just a RAM

// Do not touch the following line it is required for simulation 
`timescale 1ns/100ps

// for simulation purposes, do not delete
`default_nettype none

`define MEM_SIZE   12'hEFF // Size of RAM

// module definition

module mu0_memory(input  wire        Clk, 
	              input  wire        Wr, 
				  input  wire        Rd, 
				  input  wire [11:0] Addr, 
				  input  wire [15:0] Data_in, 
				  output reg  [15:0] Data_out);


reg [15:0] mem [12'h000:`MEM_SIZE];	// memory array

initial
$readmemh("MU0_test.mem", mem); // load default MU0 test program


// RAM
always @ (negedge Clk) // Done to make SRAM look like asynchronous RAM, makes simulation work
 begin
  if(Wr) mem[Addr] <= Data_in;  // Write cpu data to ram
  if(Rd) Data_out <= mem[Addr];  // CPU reads from ram
 end
 
 endmodule

// for simulation purposes, do not delete
`default_nettype wire
