`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2023 15:16:24
// Design Name: 
// Module Name: MEMS_gyroscope_LMSD
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


module MEMS_gyroscope_LMSD(
 input clk,
 output reg [15:0] w1_next,
 output reg [15:0] w2_next
);
// Lookup table to store the values of the sine wave
wire [7:0] sine_table[0:50];
assign sine_table[0] = 8'b00000000;
assign sine_table[1] = 8'b11010011;
assign sine_table[2] = 8'b01101101;
assign sine_table[3] = 8'b10011111;
assign sine_table[4] = 8'b00111111;
assign sine_table[5] = 8'b01011010;
assign sine_table[6] = 8'b11001011;
assign sine_table[7] = 8'b01100001;
assign sine_table[8] = 8'b10000001;
assign sine_table[9] = 8'b00100010;
assign sine_table[10] = 8'b01001110;
assign sine_table[11] = 8'b10100010;
assign sine_table[12] = 8'b11011000;
assign sine_table[13] = 8'b11111100;
assign sine_table[14] = 8'b00011111;
assign sine_table[15] = 8'b00110011;
assign sine_table[16] = 8'b01010101;
assign sine_table[17] = 8'b10110110;
assign sine_table[18] = 8'b11100010;
assign sine_table[19] = 8'b11010000;
assign sine_table[20] = 8'b01101001;
assign sine_table[21] = 8'b11100101;
assign sine_table[22] = 8'b11001001;
assign sine_table[23] = 8'b10101110;
assign sine_table[24] = 8'b01101001;
assign sine_table[25] = 8'b10000000;
assign sine_table[26] = 8'b01101101;
assign sine_table[27] = 8'b01011001;
assign sine_table[28] = 8'b01000010;
assign sine_table[29] = 8'b00110011;
assign sine_table[30] = 8'b00011110;
assign sine_table[31] = 8'b01101001;
assign sine_table[32] = 8'b00010101;
assign sine_table[33] = 8'b00001111;
assign sine_table[34] = 8'b01101001;
assign sine_table[35] = 8'b00000011;
assign sine_table[36] = 8'b01101001;
assign sine_table[37] = 8'b00000001;
assign sine_table[38] = 8'b00000000;
assign sine_table[39] = 8'b00000001;
assign sine_table[40] = 8'b00000011;
assign sine_table[41] = 8'b00000110;
assign sine_table[42] = 8'b00001001;
assign sine_table[43] = 8'b00010101;
assign sine_table[44] = 8'b00011110;
assign sine_table[45] = 8'b01101001;
assign sine_table[46] = 8'b00101001;
assign sine_table[47] = 8'b00110011;
assign sine_table[48] = 8'b01000010;
assign sine_table[49] = 8'b01011001;
assign sine_table[50] = 8'b01101101;
// Lookup table to store the values of the cosine wave
wire [7:0] cos_table[0:50];
assign cos_table[0] = 8'b11111111;
assign cos_table[1] = 8'b11111110;
assign cos_table[2] = 8'b11111100;
assign cos_table[3] = 8'b11111001;
assign cos_table[4] = 8'b11110111;
assign cos_table[5] = 8'b11110000;
assign cos_table[6] = 8'b11101010;
assign cos_table[7] = 8'b11100001;
assign cos_table[8] = 8'b11010111;
assign cos_table[9] = 8'b11001101;
assign cos_table[10] = 8'b10111110;
assign cos_table[11] = 8'b10100111;
assign cos_table[12] = 8'b10010011;
assign cos_table[13] = 8'b01111111;
assign cos_table[14] = 8'b01101001;
assign cos_table[15] = 8'b01010001;
assign cos_table[16] = 8'b00110110;
assign cos_table[17] = 8'b00011010;
assign cos_table[18] = 8'b00000001;
assign cos_table[19] = 8'b00000000;
assign cos_table[20] = 8'b00000001;
assign cos_table[21] = 8'b00011010;
assign cos_table[22] = 8'b00110110;
assign cos_table[23] = 8'b01010001;
assign cos_table[24] = 8'b01101001;
assign cos_table[25] = 8'b01111111;
assign cos_table[26] = 8'b10010011;
assign cos_table[27] = 8'b10100111;
assign cos_table[28] = 8'b10111110;
assign cos_table[29] = 8'b11001101;
assign cos_table[30] = 8'b11010111;
assign cos_table[31] = 8'b11100001;
assign cos_table[32] = 8'b11101010;
assign cos_table[33] = 8'b11110000;
assign cos_table[34] = 8'b11110111;
assign cos_table[35] = 8'b11111001;
assign cos_table[36] = 8'b11111100;
assign cos_table[37] = 8'b11111110;
assign cos_table[38] = 8'b11111111;
assign cos_table[39] = 8'b11111110;
assign cos_table[40] = 8'b11111100;
assign cos_table[41] = 8'b11111001;
assign cos_table[42] = 8'b11110111;
assign cos_table[43] = 8'b11110000;
assign cos_table[44] = 8'b11101010;
assign cos_table[45] = 8'b11100001;
assign cos_table[46] = 8'b11010111;
assign cos_table[47] = 8'b11001101;
assign cos_table[48] = 8'b10111110;
assign cos_table[49] = 8'b10100111;
assign cos_table[50] = 8'b10010011;
wire [7:0] gyro[0:50];
assign gyro[0] = 8'b00000000;
assign gyro[1] = 8'b00000001;
assign gyro[2] = 8'b00000001;
assign gyro[3] = 8'b00000001;
assign gyro[4] = 8'b00000000;
assign gyro[5] = 8'b00000000;
assign gyro[6] = 8'b00000000;
assign gyro[7] = 8'b11111111;
assign gyro[8] = 8'b11111111;
assign gyro[9] = 8'b11111111;
assign gyro[10] = 8'b11111111;
assign gyro[11] = 8'b00000000;
assign gyro[12] = 8'b00000000;
assign gyro[13] = 8'b00000000;
assign gyro[14] = 8'b00000001;
assign gyro[15] = 8'b00000001;
assign gyro[16] = 8'b00000001;
assign gyro[17] = 8'b00000000;
assign gyro[18] = 8'b00000000;
assign gyro[19] = 8'b00000000;
assign gyro[20] = 8'b11111111;
assign gyro[21] = 8'b11111111;
assign gyro[22] = 8'b11111111;
assign gyro[23] = 8'b11111111;
assign gyro[24] = 8'b00000000;
assign gyro[25] = 8'b00000000;
assign gyro[26] = 8'b00000000;
assign gyro[27] = 8'b00000001;
assign gyro[28] = 8'b00000001;
assign gyro[29] = 8'b00000001;
assign gyro[30] = 8'b00000000;
assign gyro[31] = 8'b00000000;
assign gyro[32] = 8'b00000000;
assign gyro[33] = 8'b11111111;
assign gyro[34] = 8'b11111111;
assign gyro[35] = 8'b11111111;
assign gyro[36] = 8'b11111111;
assign gyro[37] = 8'b00000000;
assign gyro[38] = 8'b00000000;
assign gyro[39] = 8'b00000000;
assign gyro[40] = 8'b00000001;
assign gyro[41] = 8'b00000001;
assign gyro[42] = 8'b00000001;
assign gyro[43] = 8'b00000000;
assign gyro[44] = 8'b00000000;
assign gyro[45] = 8'b00000000;
assign gyro[46] = 8'b11111111;
assign gyro[47] = 8'b11111111;
assign gyro[48] = 8'b11111111;
assign gyro[49] = 8'b11111111;
assign gyro[50] = 8'b00000000;
reg [15:0] Weight;
reg [15:0] w1 = 0;
reg [15:0] w2 = 0;
reg [15:0] mu = 1;
reg [15:0] error;
reg [8:0] sine;
reg [8:0] cos;
reg [15:0] a;
reg [15:0] b;
reg [16:0] i = 0 ;
always @(posedge clk) begin
 if (i == 51) begin
 i = 0; // Reset i back to 0 after reaching the maximum index
 end
 else begin

 sine = sine_table[i];
 cos = cos_table[i];
 a = w1*(sine);
 b = w2*(cos);
 Weight = a + b;
 error = gyro[i] - Weight;
 w1_next = w1 + (2 * mu * error * sine);
 w2_next = w2 + (2 * mu * error * cos);
 i = i+1;
 end
end
always@(posedge clk) begin
 w1 = w1_next;
 w2 = w2_next;
// Increment index on every clock cycle
end
endmodule
