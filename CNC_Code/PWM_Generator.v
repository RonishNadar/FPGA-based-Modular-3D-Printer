`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:48:24 04/21/2023 
// Design Name: 
// Module Name:    PWM_Generator 
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
module PWM_Generator(
	input i_Clock50MHz,             // Clock input
	input [7:0] i_DutyCycle, 		  // Input Duty Cycle
	output o_PWMOut         		  // Output PWM
);
 
	// 8-BIT COUNTER
	reg [7:0] r_Counter = 8'd0;
	
	always @(posedge i_Clock50MHz)
		if (r_Counter<8'd255)
		begin
			r_Counter <= r_Counter + 8'd1;
		end
		else
		begin
			r_Counter <= 8'd0;
		end
	
	assign o_PWMOut = (r_Counter < i_DutyCycle);

////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule