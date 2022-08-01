// MU0 12 bit register testbench
// P W Nutter (based on a design by Jeff Pepper)
// Date 20/8/2021
//

// Do not touch the following line it is required for simulation
`timescale 1ns/100ps

// module header
module mu0_reg12_tb();

// Define any internal connections
reg Clk;
reg Reset;
reg En;
reg[11:0] D;
wire[11:0] Q;


// Instantiate mu0_reg12 as dut (device under test)
mu0_reg12 dut(Clk, Reset, En, D, Q);

// Set up the clock
// the following initial block initialises the clock
initial Clk = 0;

// the following always block creates the clock signal
always
 begin
    #50
    Clk = ~Clk;     //Inverts the Clock
 end

// Test vectors
initial
begin
  D = 12'hAAA;
	#0 Reset = 1'b1; En = 1'b1; // check if D is not loaded since Reset is high (even though En is high)
	#200 Reset = 1'b0;
  D = 12'hBBB;
	#200 Reset = 1'b0; En = 1'b0; // check if new value of D not loaded since En is low
	#200 Reset = 1'b0; En = 1'b1;
	#275 Reset = 1'b1;  // Test to check is Reset is asynchronous
	#125 Reset = 1'b0;
	#200 En = 1'b0;
	#200 Reset = 1'b1; // Checking if Reset overwrites data even if En is low
  #100 $finish;      // end the simulation
end

// Save results as VCD file
// Do not change
initial
 begin
  $dumpfile("mu0_reg12_tb_results.vcd");  // Save simulation waveforms in this file
  $dumpvars; // Capture all simulation waveforms
 end

endmodule
