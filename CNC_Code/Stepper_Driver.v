`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2023 15:36:27
// Design Name: 
// Module Name: Stepper_Driver
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

module Stepper_Driver (
	Reset,
	Clock100Mhz,
	StepWrite,
	FeedRate,
	LimitStart,
	LimitEnd,
	Direction,
	StepCount,
	StepOutput,
	Waiting
);


input wire	Reset;
input wire	Clock100Mhz;
input wire	StepWrite;
input wire  LimitStart;
input wire  LimitEnd;
input wire  Direction;
input wire [19:0] FeedRate;
input wire	[19:0] StepCount;
output wire	StepOutput;
output wire	Waiting;

wire	SYNTHESIZED_WIRE_0;

Step_Generator	SG1(
	.i_clock(SYNTHESIZED_WIRE_0),
	.i_step_write(StepWrite),
	.i_reset(Reset),
	.i_LimitStart(LimitStart),
	.i_LimitEnd(LimitEnd),
	.i_Direction(Direction),
	.i_step_count(StepCount),
	.o_step(StepOutput),
	.o_waiting(Waiting));


Clock_Divider	CD1(
	.i_clock(Clock100Mhz),
	.i_reset(Reset),
	.i_feedrate(FeedRate),
	.o_div_clock(SYNTHESIZED_WIRE_0));


endmodule

