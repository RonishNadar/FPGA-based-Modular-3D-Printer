`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:45:54 04/15/2023 
// Design Name: 
// Module Name:    G_code_TOP 
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
module G_code_TOP(
	input i_Clock50MHz,
	input i_Reset,
	input i_RXG,
	input i_RXT,
	input i_Select0,
	input i_Select1,
	input i_Select2,
	input i_LimitStartX,
	input i_LimitEndX,
	input i_LimitStartY,
	input i_LimitEndY,
	input i_LimitStartZ,
	input i_LimitEndZ,
	output o_Waiting,
	output o_XDirection,
	output o_YDirection,
	output o_ZDirection,
	output o_EDirection,
	output o_XStep,
	output o_YStep,
	output o_ZStep,
	output o_EStep,
	output o_HotTemp,
	output o_BedTemp,
	output o_FanSpeed,
	output [7:0] o_LEDs
   );
	
	wire w_SerialReadyG;
	wire [7:0] w_SerialDataG;
	wire w_SerialReadyT;
	wire [7:0] w_SerialDataT;
	
	wire [47:0] w_FValue;
	wire [47:0] w_XValue;
	wire [47:0] w_YValue;
	wire [47:0] w_ZValue;
	wire [47:0] w_EValue;
	
	wire [23:0] w_HValue;
	wire [23:0] w_BValue;
	
	wire [23:0] w_M1Value;
	wire [23:0] w_M2Value;
	wire [23:0] w_M3Value;
	
	wire [19:0] w_FBinary;
	wire [19:0] w_XBinary;
	wire [19:0] w_YBinary;
	wire [19:0] w_ZBinary;
	wire [19:0] w_EBinary;
	
	wire [7:0] w_HBinary;
	wire [7:0] w_BBinary;
	
	wire [7:0] w_S1Binary;
	wire [7:0] w_S2Binary;
	wire [7:0] w_S3Binary;
	
	wire w_WaitingX;
	wire w_WaitingY;
	wire w_WaitingZ;
	wire w_WaitingE;
	
	wire w_LineCompleteG;
	wire w_LineCompleteT;
	wire w_StepWrite;
	wire w_DividedClock;
	
	UART_Receiver UR1 (
	.clk_50MHz(i_Clock50MHz),
	.reset(i_Reset),
	.rx(i_RXG),
	.data_ready(w_SerialReadyG),
	.data_reg(w_SerialDataG)
	);
	
	UART_Receiver UR2 (
	.clk_50MHz(i_Clock50MHz),
	.reset(i_Reset),
	.rx(i_RXT),
	.data_ready(w_SerialReadyT),
	.data_reg(w_SerialDataT)
	);
	
	G_Code_Decoder GCD1 (
	.i_Clock50MHz(i_Clock50MHz),
	.i_Reset(i_Reset),
	.i_SerialReady(w_SerialReadyG),
	.i_SerialData(w_SerialDataG),
	.o_STATE(),
	.o_FValue(w_FValue),
	.o_XValue(w_XValue),
	.o_YValue(w_YValue),
	.o_ZValue(w_ZValue),
	.o_EValue(w_EValue),
	.o_M1Value(w_M1Value),
	.o_M2Value(w_M2Value),
	.o_M3Value(w_M3Value),
	.o_XDirection(o_XDirection),
	.o_YDirection(o_YDirection),
	.o_ZDirection(o_ZDirection),
	.o_EDirection(o_EDirection),
	.o_LineComplete(w_LineCompleteG)
	);
	
	Temperature_Decoder TD1 (
	.i_Clock50MHz(i_Clock50MHz),
	.i_Reset(i_Reset),
	.i_SerialReady(w_SerialReadyT),
	.i_SerialData(w_SerialDataT),
	.o_HotTempAscii(w_HValue),
	.o_BedTempAscii(w_BValue),
	.o_LineComplete(w_LineCompleteT),
	.o_STATE()
	);
		
	Ascii2Binary_4D AB41 (
	.i_Clock50MHz(i_Clock50MHz),
	.i_Reset(i_Reset),
	.i_LineComplete(w_LineCompleteG),
	.i_AsciiValue(w_FValue),
	.o_BinaryValue(w_FBinary)
	);
	
	
	Ascii2Binary_4D AB42 (
	.i_Clock50MHz(i_Clock50MHz),
	.i_Reset(i_Reset),
	.i_LineComplete(w_LineCompleteG),
	.i_AsciiValue(w_XValue),
	.o_BinaryValue(w_XBinary)
	);
	
	Ascii2Binary_4D AB43 (
	.i_Clock50MHz(i_Clock50MHz),
	.i_Reset(i_Reset),
	.i_LineComplete(w_LineCompleteG),
	.i_AsciiValue(w_YValue),
	.o_BinaryValue(w_YBinary)
	);
	
	Ascii2Binary_4D AB44 (
	.i_Clock50MHz(i_Clock50MHz),
	.i_Reset(i_Reset),
	.i_LineComplete(w_LineCompleteG),
	.i_AsciiValue(w_ZValue),
	.o_BinaryValue(w_ZBinary)
	);
	
	Ascii2Binary_4D AB45 (
	.i_Clock50MHz(i_Clock50MHz),
	.i_Reset(i_Reset),
	.i_LineComplete(w_LineCompleteG),
	.i_AsciiValue(w_EValue),
	.o_BinaryValue(w_EBinary)
	);
	
	Ascii2Binary_3D AB31 (
	.i_Clock50MHz(i_Clock50MHz),
	.i_Reset(i_Reset),
	.i_LineComplete(w_LineCompleteG),
	.i_AsciiValue(w_M1Value),
	.o_BinaryValue(w_S1Binary)
	);
	
	Ascii2Binary_3D AB32 (
	.i_Clock50MHz(i_Clock50MHz),
	.i_Reset(i_Reset),
	.i_LineComplete(w_LineCompleteG),
	.i_AsciiValue(w_M2Value),
	.o_BinaryValue(w_S2Binary)
	);
	
	Ascii2Binary_3D AB33 (
	.i_Clock50MHz(i_Clock50MHz),
	.i_Reset(i_Reset),
	.i_LineComplete(w_LineCompleteG),
	.i_AsciiValue(w_M3Value),
	.o_BinaryValue(w_S3Binary)
	);
	
	Ascii2Binary_3D AB34 (
	.i_Clock50MHz(i_Clock50MHz),
	.i_Reset(i_Reset),
	.i_LineComplete(w_LineCompleteT),
	.i_AsciiValue(w_HValue),
	.o_BinaryValue(w_HBinary)
	);
	
	Ascii2Binary_3D AB35 (
	.i_Clock50MHz(i_Clock50MHz),
	.i_Reset(i_Reset),
	.i_LineComplete(w_LineCompleteT),
	.i_AsciiValue(w_BValue),
	.o_BinaryValue(w_BBinary)
	);

	
	Clock_Divider_PWM	CDP(
	.clock_in(i_Clock50MHz),
	.clock_out(w_DividedClock)
	);

	PWM_Generator PG1 (
	.i_Clock50MHz(w_DividedClock),
	.i_DutyCycle(w_S1Binary),
	.o_PWMOut(o_HotTemp)
	);
	
	PWM_Generator PG2 (
	.i_Clock50MHz(w_DividedClock),
	.i_DutyCycle(w_S2Binary),
	.o_PWMOut(o_BedTemp)
	);
	
	PWM_Generator PG3 (
	.i_Clock50MHz(w_DividedClock),
	.i_DutyCycle(w_S3Binary),
	.o_PWMOut(o_FanSpeed)
	);
	
	Eight2OneMux E2O1(
	.D0(w_HBinary[7:0]),
	.D1(w_BBinary[7:0]),
	.D2(w_XBinary[7:0]),
	.D3(w_YBinary[7:0]),
	.D4(w_ZBinary[7:0]),
	.D5(w_EBinary[7:0]),
	.D6(w_S1Binary[7:0]),
	.D7(w_S2Binary[7:0]),
	.S0(i_Select0),
	.S1(i_Select1),
	.S2(i_Select2),
	.Out(o_LEDs[5:0])
	);
	
	StepWriteGenerator SWG1 (
	.i_Clock50MHz(i_Clock50MHz),
	.i_Reset(i_Reset),
	.i_SerialReady(w_SerialReadyG),
	.o_StepWrite(w_StepWrite),
	.r_STATE(o_LEDs[6])
	);
	
	Stepper_Driver SD1X (
	.Clock100Mhz(i_Clock50MHz),
	.Reset(i_Reset),
	.StepWrite(w_StepWrite),
	.FeedRate(20'd250),
	.LimitStart(i_LimitStartX),
	.LimitEnd(i_LimitEndX),
	.Direction(~o_XDirection),
	.StepCount(w_XBinary),
	.StepOutput(o_XStep),
	.Waiting(w_WaitingX)
	);
	
	Stepper_Driver SD2Y (
	.Clock100Mhz(i_Clock50MHz),
	.Reset(i_Reset),
	.StepWrite(w_StepWrite),
	.FeedRate(20'd250),
	.LimitStart(i_LimitStartY),
	.LimitEnd(i_LimitEndY),
	.Direction(o_YDirection),
	.StepCount(w_YBinary),
	.StepOutput(o_YStep),
	.Waiting(w_WaitingY)
	);
	
	Stepper_Driver SD3Z (
	.Clock100Mhz(i_Clock50MHz),
	.Reset(i_Reset),
	.StepWrite(w_StepWrite),
	.FeedRate(20'd250),
	.LimitStart(i_LimitStartZ),
	.LimitEnd(i_LimitEndZ),
	.Direction(o_ZDirection),
	.StepCount(w_ZBinary),
	.StepOutput(o_ZStep),
	.Waiting(w_WaitingZ)
	);
	
	Stepper_Driver SD3E (
	.Clock100Mhz(i_Clock50MHz),
	.Reset(i_Reset),
	.StepWrite(w_StepWrite),
	.FeedRate(w_FBinary),
	.LimitStart(1'b0),
	.LimitEnd(1'b0),
	.Direction(o_EDirection),
	.StepCount(w_EBinary),
	.StepOutput(o_EStep),
	.Waiting(w_WaitingE)
	);
	
	FourInputANDGate FIAG1(
	.i_InputX(w_WaitingX),
	.i_InputY(w_WaitingY),
	.i_InputZ(w_WaitingZ),
	.i_InputE(w_WaitingE),
	.o_Output(o_Waiting)
	);
	
	assign o_LEDs[7] = o_Waiting;
	
endmodule
