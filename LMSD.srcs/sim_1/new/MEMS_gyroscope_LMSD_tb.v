`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2023 15:17:04
// Design Name: 
// Module Name: MEMS_gyroscope_LMSD_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MEMS_gyroscope_LMSD_tb;

 reg clk;
 wire [15:0] w1_next = 0;
 wire [15:0] w2_next = 0;

 MEMS_gyroscope_LMSD dut (
 .clk(clk),
 .w1_next(w1_next),
 .w2_next(w2_next)
 );

 initial begin
 clk = 0;
 forever #5 clk = ~clk; // Generate clock with a period of 10 units
 end

 initial begin
 // Initialize inputs
 #10; // Wait for some time to allow the module to stabilize

 // Apply stimulus
 repeat (50) begin
 #10; // Wait for some time

 // Display outputs
 $display("w1_next: %h, w2_next: %h", w1_next, w2_next);
 end

 $finish; // End the simulation
 end

endmodule
