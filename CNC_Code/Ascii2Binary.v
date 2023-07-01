`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:12:48 04/15/2023 
// Design Name: 
// Module Name:    Ascii2Binary 
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

// FOR 4 DIGITS
module Ascii2Binary_4D(
    input i_Clock50MHz,
    input i_Reset,
    input i_LineComplete,
    input [47:0] i_AsciiValue,
    output reg [19:0] o_BinaryValue
);

	reg [7:0] ascii_digit0, ascii_digit1, ascii_digit2, ascii_digit3, ascii_digit4, ascii_digit5;
	
	initial begin
		o_BinaryValue = 16'd0;
		ascii_digit0  = 8'd0;
		ascii_digit1  = 8'd0;
		ascii_digit2  = 8'd0;
		ascii_digit3  = 8'd0;
		ascii_digit4  = 8'd0;
		ascii_digit5  = 8'd0;
	end
	
	always @(posedge i_Clock50MHz or posedge i_Reset) begin
		if (i_Reset) begin
		  o_BinaryValue = 16'd0;
		  ascii_digit0  = 8'd0;
		  ascii_digit1  = 8'd0;
		  ascii_digit2  = 8'd0;
		  ascii_digit3  = 8'd0;
		  ascii_digit4  = 8'd0;
		  ascii_digit5  = 8'd0;
		end 
		else begin
			if (i_LineComplete) begin
				// Extract ASCII digits from input bus
				if (i_AsciiValue[7:0] == 8'd0) begin
					ascii_digit0 = 8'd48;
				end
				if (i_AsciiValue[15:8] == 8'd0) begin
					ascii_digit1 = 8'd48;
				end
				if (i_AsciiValue[23:16] == 8'd0) begin
					ascii_digit2 = 8'd48;
				end
				if (i_AsciiValue[31:24] == 8'd0) begin
					ascii_digit3 = 8'd48;
				end
				if (i_AsciiValue[39:32] == 8'd0) begin
					ascii_digit4 = 8'd48;
				end
				if (i_AsciiValue[47:40] == 8'd0) begin
					ascii_digit5 = 8'd48;
				end
				if (i_AsciiValue[7:0] != 8'd0) begin
					ascii_digit0 = i_AsciiValue[7:0];
				end
				if (i_AsciiValue[15:8] != 8'd0) begin
					ascii_digit1 = i_AsciiValue[15:8];
				end
				if (i_AsciiValue[23:16] != 8'd0) begin
					ascii_digit2 = i_AsciiValue[23:16];
				end
				if (i_AsciiValue[31:24] != 8'd0) begin
					ascii_digit3 = i_AsciiValue[31:24];
				end
				if (i_AsciiValue[39:32] != 8'd0) begin
					ascii_digit4 = i_AsciiValue[39:32];
				end
				if (i_AsciiValue[47:40] != 8'd0) begin
					ascii_digit5 = i_AsciiValue[47:40];
				end
				// Perform ASCII to binary conversion
				o_BinaryValue = (ascii_digit5 - 8'd48) * 100000 +
									 (ascii_digit4 - 8'd48) * 10000 +
									 (ascii_digit3 - 8'd48) * 1000 +
									 (ascii_digit2 - 8'd48) * 100 +
									 (ascii_digit1 - 8'd48) * 10 +
									 (ascii_digit0 - 8'd48);
			end
		end
	end

endmodule

// FOR 3 DIGITS
module Ascii2Binary_3D(
    input i_Clock50MHz,
    input i_Reset,
    input i_LineComplete,
    input [23:0] i_AsciiValue,
    output reg [7:0] o_BinaryValue
);

	reg [7:0] ascii_digit0, ascii_digit1, ascii_digit2;
	
	initial begin
		o_BinaryValue = 16'd0;
		ascii_digit0  = 8'd0;
		ascii_digit1  = 8'd0;
		ascii_digit2  = 8'd0;
	end
	
	always @(posedge i_Clock50MHz or posedge i_Reset) begin
		if (i_Reset) begin
		  o_BinaryValue = 16'd0;
		  ascii_digit0  = 8'd0;
		  ascii_digit1  = 8'd0;
		  ascii_digit2  = 8'd0;
		end 
		else begin
			if (i_LineComplete) begin
				// Extract ASCII digits from input bus
				if (i_AsciiValue[7:0] == 8'd0) begin
					ascii_digit0 = 8'd48;
				end
				if (i_AsciiValue[15:8] == 8'd0) begin
					ascii_digit1 = 8'd48;
				end
				if (i_AsciiValue[23:16] == 8'd0) begin
					ascii_digit2 = 8'd48;
				end
				if (i_AsciiValue[7:0] != 8'd0) begin
					ascii_digit0 = i_AsciiValue[7:0];
				end
				if (i_AsciiValue[15:8] != 8'd0) begin
					ascii_digit1 = i_AsciiValue[15:8];
				end
				if (i_AsciiValue[23:16] != 8'd0) begin
					ascii_digit2 = i_AsciiValue[23:16];
				end
				// Perform ASCII to binary conversion
				o_BinaryValue = (ascii_digit2 - 8'd48) * 100 +
									 (ascii_digit1 - 8'd48) * 10 +
									 (ascii_digit0 - 8'd48);
			end
		end
	end

endmodule
