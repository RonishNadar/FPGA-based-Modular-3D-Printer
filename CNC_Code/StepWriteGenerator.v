`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:26:45 04/19/2023 
// Design Name: 
// Module Name:    StepWriteGenerator 
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
module StepWriteGenerator(
	input i_Clock50MHz,
	input i_Reset,
	input i_SerialReady,
	output reg o_StepWrite,
	output reg [1:0] r_STATE
   );
	
	reg [31:0] r_Counter1;
	reg [31:0] r_Counter2;
	
	localparam s_IDLE = 2'd0;
	localparam s_1		= 2'd1;
	localparam s_2		= 2'd2;
		
	initial begin
		r_STATE   <= 2'd0;
		o_StepWrite <= 1'b0;
		r_Counter1 <= 32'd0;
		r_Counter2 <= 32'd0;
	end
	
	always @(posedge i_Clock50MHz, posedge i_Reset) begin
		if (i_Reset) begin
			r_STATE   <= 2'd0;
			o_StepWrite <= 1'b0;
			r_Counter1 <= 32'd0;
			r_Counter2 <= 32'd0;
		end
		else begin
			case (r_STATE)
			s_IDLE: begin
				if(i_SerialReady) begin
					r_STATE <= s_1;
				end
				else begin
					o_StepWrite <= 1'b0;
					r_Counter1 <= 32'd0;
					r_Counter2 <= 32'd0;
					r_STATE <= s_IDLE;
				end
			end
			s_1: begin
				if (r_Counter1 < 32'd3_000_000) begin
					r_Counter1 <= r_Counter1 + 1;
					r_STATE <= s_1;
				end
				else begin
					r_Counter1 <= 32'd0;
					r_STATE <= s_2;
				end
			end
			s_2: begin
				if (r_Counter2 < 32'd25_000) begin
					r_Counter2 <= r_Counter2 + 1;
					o_StepWrite <= 1'b1;
					r_STATE <= s_2;
				end
				else begin
					r_Counter2 <= 32'd0;
					o_StepWrite <= 1'b0;
					r_STATE <= s_IDLE;
				end
			end
			endcase
		end
	end


endmodule
