`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:39:50 04/21/2023 
// Design Name: 
// Module Name:    Temperature_Regulator 
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
module Temperature_Regulator (
	input i_Clock50MHz,
	input [7:0] i_Live,
	input [7:0] i_Thresh,
	output o_Temp_Regulator
);
	
	reg r_Temp_Val;
	reg [7:0] r_Thresh_Buffer;
	
	initial begin
		r_Temp_Val = 1'b0;
		r_Thresh_Buffer = 8'd180;
	end
	
	always @(posedge i_Clock50MHz) begin
	
		if (r_Thresh_Buffer != i_Thresh) begin
			r_Thresh_Buffer = i_Thresh;
		end
		
		if (i_Live > r_Thresh_Buffer) begin
			r_Temp_Val = 1'b0;
		end
		else begin
			r_Temp_Val = 1'b1;
		end
	end
	
	assign o_Temp_Regulator = r_Temp_Val;
	
endmodule