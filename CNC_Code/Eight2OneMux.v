`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:42:43 04/18/2023 
// Design Name: 
// Module Name:    TwoBitMux 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Eight2OneMux(
	input [7:0] D0,
	input [7:0] D1,
	input	[7:0] D2,
	input [7:0] D3,
	input [7:0] D4,
	input [7:0] D5,
	input [7:0] D6,
	input [7:0] D7,
	input S0,
	input S1,
	input S2,
	output [7:0] Out
	);
	
	assign S1bar=~S1;
	assign S0bar=~S0;
	assign S2bar=~S2;
	
	assign Out[0] = (D0[0] & S2bar & S1bar & S0bar) | (D1[0] & S2bar & S1bar & S0) | (D2[0] & S2bar & S1 & S0bar) + (D3[0] & S2bar & S1 & S0) + (D4[0] & S2 & S1bar & S0bar) + (D5[0] & S2 & S1bar & S0) + (D6[0] & S2 & S1 & S0bar) + (D7[0] & S2 & S1 & S0);
	assign Out[1] = (D0[1] & S2bar & S1bar & S0bar) | (D1[1] & S2bar & S1bar & S0) | (D2[1] & S2bar & S1 & S0bar) + (D3[1] & S2bar & S1 & S0) + (D4[1] & S2 & S1bar & S0bar) + (D5[1] & S2 & S1bar & S0) + (D6[1] & S2 & S1 & S0bar) + (D7[1] & S2 & S1 & S0);
	assign Out[2] = (D0[2] & S2bar & S1bar & S0bar) | (D1[2] & S2bar & S1bar & S0) | (D2[2] & S2bar & S1 & S0bar) + (D3[2] & S2bar & S1 & S0) + (D4[2] & S2 & S1bar & S0bar) + (D5[2] & S2 & S1bar & S0) + (D6[2] & S2 & S1 & S0bar) + (D7[2] & S2 & S1 & S0);
	assign Out[3] = (D0[3] & S2bar & S1bar & S0bar) | (D1[3] & S2bar & S1bar & S0) | (D2[3] & S2bar & S1 & S0bar) + (D3[3] & S2bar & S1 & S0) + (D4[3] & S2 & S1bar & S0bar) + (D5[3] & S2 & S1bar & S0) + (D6[3] & S2 & S1 & S0bar) + (D7[3] & S2 & S1 & S0);
	assign Out[4] = (D0[4] & S2bar & S1bar & S0bar) | (D1[4] & S2bar & S1bar & S0) | (D2[4] & S2bar & S1 & S0bar) + (D3[4] & S2bar & S1 & S0) + (D4[4] & S2 & S1bar & S0bar) + (D5[4] & S2 & S1bar & S0) + (D6[4] & S2 & S1 & S0bar) + (D7[4] & S2 & S1 & S0);
	assign Out[5] = (D0[5] & S2bar & S1bar & S0bar) | (D1[5] & S2bar & S1bar & S0) | (D2[5] & S2bar & S1 & S0bar) + (D3[5] & S2bar & S1 & S0) + (D4[5] & S2 & S1bar & S0bar) + (D5[5] & S2 & S1bar & S0) + (D6[5] & S2 & S1 & S0bar) + (D7[5] & S2 & S1 & S0);
	assign Out[6] = (D0[6] & S2bar & S1bar & S0bar) | (D1[6] & S2bar & S1bar & S0) | (D2[6] & S2bar & S1 & S0bar) + (D3[6] & S2bar & S1 & S0) + (D4[6] & S2 & S1bar & S0bar) + (D5[6] & S2 & S1bar & S0) + (D6[6] & S2 & S1 & S0bar) + (D7[6] & S2 & S1 & S0);
	assign Out[7] = (D0[7] & S2bar & S1bar & S0bar) | (D1[7] & S2bar & S1bar & S0) | (D2[7] & S2bar & S1 & S0bar) + (D3[7] & S2bar & S1 & S0) + (D4[7] & S2 & S1bar & S0bar) + (D5[7] & S2 & S1bar & S0) + (D6[7] & S2 & S1 & S0bar) + (D7[7] & S2 & S1 & S0);
	
endmodule
