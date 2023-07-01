`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:54:42 04/19/2023 
// Design Name: 
// Module Name:    Temperature_Decoder 
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
module Temperature_Decoder(
	input i_Clock50MHz,
	input i_Reset,
	input i_SerialReady,
	input [7:0] i_SerialData,
	output reg [23:0] o_HotTempAscii,
	output reg [23:0] o_BedTempAscii,
	output reg o_LineComplete,
	output [1:0] o_STATE
   );
	
	localparam s_IDLE 	 = 4'd0;
	localparam s_HOT 		 = 4'd1;
	localparam s_BED 		 = 4'd2;
	localparam s_COMPLETE = 4'd3;
	
	reg [3:0] r_STATE;
	reg [6:0] r_CompleteCounter;
	
	initial begin
		o_HotTempAscii 	= 24'd0;
		o_BedTempAscii 	= 24'd0;
		o_LineComplete 	= 1'b0;
		r_STATE				= 4'd0;
		r_CompleteCounter = 7'd0;
	end
	
	always @(posedge i_Clock50MHz, posedge i_Reset) begin
		if (i_Reset) begin
			o_HotTempAscii 	= 24'd0;
			o_BedTempAscii 	= 24'd0;
			o_LineComplete 	= 1'b0;
			r_STATE				= 4'd0;
			r_CompleteCounter = 7'd0;
		end
		else begin
			case (r_STATE)
				s_IDLE: begin
					r_CompleteCounter = 7'd0;
					o_LineComplete 	= 1'b0;
					
					// SPACE
					if ((i_SerialReady) && i_SerialData == 8'd32) begin
						r_STATE = s_IDLE;
					end
					// ENTER
					else if ((i_SerialReady) && i_SerialData == 8'd13) begin
						r_STATE = s_IDLE;
					end
					// H
					else  if ((i_SerialReady) && i_SerialData == 8'd72) begin
						o_HotTempAscii = 24'd0;
						r_STATE  		= s_HOT;
					end
					// B
					else  if ((i_SerialReady) && i_SerialData == 8'd66) begin
						o_BedTempAscii = 24'd0;
						r_STATE  		= s_BED;
					end
					else begin
						r_STATE = s_IDLE;
					end
				end
				s_HOT: begin
					// ENTER
					if ((i_SerialReady) && i_SerialData == 8'd13) begin
						r_STATE = s_COMPLETE;
					end
					// HOT END TEMP. DATA COLLECTION
					else if ((i_SerialReady) && (i_SerialData != 8'd13)) begin
						o_HotTempAscii 	  = o_HotTempAscii << 8;
						o_HotTempAscii[7:0] = i_SerialData;
					end
					else begin
						r_STATE = s_HOT;
					end
				end
				s_BED: begin
					// ENTER
					if ((i_SerialReady) && i_SerialData == 8'd13) begin
						r_STATE = s_COMPLETE;
					end
					// BED TEMP. DATA COLLECTION
					else if ((i_SerialReady) && (i_SerialData != 8'd13)) begin
						o_BedTempAscii 	  = o_BedTempAscii << 8;
						o_BedTempAscii[7:0] = i_SerialData;
					end
					else begin
						r_STATE = s_BED;
					end
				end
				s_COMPLETE: begin
					if (r_CompleteCounter < 7'd100) begin
						o_LineComplete = 1'b1;
						r_CompleteCounter = r_CompleteCounter + 1'b1;
						r_STATE = s_COMPLETE;
					end
					else begin
						r_CompleteCounter = 7'd0;
						r_STATE = s_IDLE;
					end
				end
			endcase
		end
	end
	
	assign o_STATE = r_STATE[1:0];
endmodule


