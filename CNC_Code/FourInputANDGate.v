`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:43:26 04/20/2023 
// Design Name: 
// Module Name:    InputANDGate 
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
module FourInputANDGate(
    input i_InputX,
    input i_InputY,
    input i_InputZ,
    input i_InputE,
    output o_Output
    );
	
	assign o_Output = i_InputX && i_InputY && i_InputZ && i_InputE;

endmodule
