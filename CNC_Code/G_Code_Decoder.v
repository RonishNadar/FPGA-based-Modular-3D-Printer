module G_Code_Decoder (
	input i_Clock50MHz,
	input i_Reset,
	input i_SerialReady,
	input [7:0] i_SerialData,
	output o_STATE,
	output reg [47:0] o_FValue,
	output reg [47:0] o_XValue,
	output reg [47:0] o_YValue,
	output reg [47:0] o_ZValue,
	output reg [47:0] o_EValue,
	output reg [23:0] o_M1Value,
	output reg [23:0] o_M2Value,
	output reg [23:0] o_M3Value,
	output reg o_XDirection,
	output reg o_YDirection,
	output reg o_ZDirection,
	output reg o_EDirection,
	output reg o_LineComplete
	);
		
	localparam s_IDLE 	 = 4'd0;
	localparam s_G 		 = 4'd1;
	localparam s_F 		 = 4'd2;
	localparam s_X 		 = 4'd3;
	localparam s_Y 		 = 4'd4;
	localparam s_Z 		 = 4'd5;
	localparam s_E 		 = 4'd6;
	localparam s_H 		 = 4'd7;
	localparam s_B 		 = 4'd8;
	localparam s_S 		 = 4'd9;
	localparam s_COMPLETE = 4'd10;
	
	reg [3:0] r_STATE;
	reg [6:0] r_CompleteCounter;
	
	initial begin
		// REGISTER INITIALIZATION
		o_FValue 			= 48'd00000000_00000000_00000000_00110010_00110101_00110000;
		o_XValue 			= 48'd0;
		o_YValue 			= 48'd0;
		o_ZValue 			= 48'd0;
		o_EValue 			= 48'd0;
		o_M1Value			= 24'd0;
		o_M2Value			= 24'd0;
		o_M3Value			= 24'd0;
		o_XDirection 		= 1'b0;
		o_YDirection 		= 1'b0;
		o_ZDirection 		= 1'b0;
		o_EDirection 		= 1'b0;
		o_LineComplete 	= 1'b0;
		r_STATE				= 4'd0;
		r_CompleteCounter = 7'd0;
	end
	
	always @(posedge i_Clock50MHz, posedge i_Reset) begin
		if (i_Reset) begin
			o_FValue 			= 48'd0;
			o_XValue 			= 48'd0;
			o_YValue 			= 48'd0;
			o_ZValue 			= 48'd0;
			o_EValue 			= 48'd0;
			o_M1Value			= 24'd0;
			o_M2Value			= 24'd0;
			o_M3Value			= 24'd0;
			o_XDirection 		= 1'b0;
			o_YDirection 		= 1'b0;
			o_ZDirection 		= 1'b0;
			o_EDirection 		= 1'b0;
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
						o_M1Value = 24'd0;
						r_STATE   = s_H;
					end
					// B
					else  if ((i_SerialReady) && i_SerialData == 8'd66) begin
						o_M2Value = 24'd0;
						r_STATE   = s_B;
					end
					// S
					else  if ((i_SerialReady) && i_SerialData == 8'd83) begin
						o_M3Value = 24'd0;
						r_STATE   = s_S;
					end
					// G
					else  if ((i_SerialReady) && i_SerialData == 8'd71) begin
						r_STATE  			= s_G;
						o_XValue 			= 48'd0;
						o_YValue 			= 48'd0;
						o_ZValue 			= 48'd0;
						o_EValue 			= 48'd0;
						o_XDirection 		= 1'b0;
						o_YDirection 		= 1'b0;
						o_ZDirection 		= 1'b0;
						o_EDirection 		= 1'b0;
					end
					else begin
						r_STATE = s_IDLE;
					end
				end
				s_H: begin
					// ENTER
					if ((i_SerialReady) && i_SerialData == 8'd13) begin
						r_STATE = s_COMPLETE;
					end
					// HOT END TEMP. DATA COLLECTION
					else if ((i_SerialReady) && (i_SerialData != 8'd13)) begin
						o_M1Value 	   = o_M1Value << 8;
						o_M1Value[7:0] = i_SerialData;
					end
					else begin
						r_STATE = s_H;
					end
				end
				s_B: begin
					// ENTER
					if ((i_SerialReady) && i_SerialData == 8'd13) begin
						r_STATE = s_COMPLETE;
					end
					// HOT END TEMP. DATA COLLECTION
					else if ((i_SerialReady) && (i_SerialData != 8'd13)) begin
						o_M2Value 	   = o_M2Value << 8;
						o_M2Value[7:0] = i_SerialData;
					end
					else begin
						r_STATE = s_B;
					end
				end
				s_S: begin
					// ENTER
					if ((i_SerialReady) && i_SerialData == 8'd13) begin
						r_STATE = s_COMPLETE;
					end
					// HOT END TEMP. DATA COLLECTION
					else if ((i_SerialReady) && (i_SerialData != 8'd13)) begin
						o_M3Value 	   = o_M3Value << 8;
						o_M3Value[7:0] = i_SerialData;
					end
					else begin
						r_STATE = s_S;
					end
				end
				s_G: begin
					// SPACE
					if ((i_SerialReady) && i_SerialData == 8'd32) begin
						r_STATE = s_G;
					end
					// ENTER
					else if ((i_SerialReady) && i_SerialData == 8'd13) begin
						r_STATE = s_COMPLETE;
					end
					// 0 or 1 
					else  if ((i_SerialReady) && (i_SerialData == 8'd48) && (i_SerialData == 8'd49)) begin
						r_STATE = s_G;
					end
					// F
					else  if ((i_SerialReady) && i_SerialData == 8'd70) begin
						r_STATE = s_F;
					end
					// X
					else  if ((i_SerialReady) && i_SerialData == 8'd88) begin
						r_STATE = s_X;
					end
					// Y
					else  if ((i_SerialReady) && i_SerialData == 8'd89) begin
						r_STATE = s_Y;
					end
					// Z
					else  if ((i_SerialReady) && i_SerialData == 8'd90) begin
						r_STATE = s_Z;
					end
					// E
					else  if ((i_SerialReady) && i_SerialData == 8'd69) begin
						r_STATE = s_E;
					end
					else begin
						r_STATE = s_G;
					end
				end
				s_F: begin
					// SPACE
					if ((i_SerialReady) && i_SerialData == 8'd32) begin
						r_STATE = s_G;
					end
					// ENTER
					else if ((i_SerialReady) && i_SerialData == 8'd13) begin
						r_STATE = s_COMPLETE;
					end
					// FEEDRATE DATA COLLECTION
					else if ((i_SerialReady) && (i_SerialData != 8'd32) && (i_SerialData != 8'd13)) begin
						o_FValue = o_FValue << 8;
						o_FValue[7:0] = i_SerialData;
					end
					else begin
						r_STATE = s_F;
					end
				end
				s_X: begin
					// SPACE
					if ((i_SerialReady) && i_SerialData == 8'd32) begin
						r_STATE = s_G;
					end
					// ENTER
					else if ((i_SerialReady) && i_SerialData == 8'd13) begin
						r_STATE = s_COMPLETE;
					end
					// MINUS
					else if ((i_SerialReady) && i_SerialData == 8'd45) begin
						o_XDirection = 1'b1;
					end
					// X DATA COLLECTION
					else if ((i_SerialReady) && (i_SerialData != 8'd32) && (i_SerialData != 8'd13) && (i_SerialData != 8'd45)) begin
						o_XValue = o_XValue << 8;
						o_XValue[7:0] = i_SerialData;
					end
					else begin
						r_STATE = s_X;
					end
				end
				s_Y: begin
					// SPACE
					if ((i_SerialReady) && i_SerialData == 8'd32) begin
						r_STATE = s_G;
					end
					// ENTER
					else if ((i_SerialReady) && i_SerialData == 8'd13) begin
						r_STATE = s_COMPLETE;
					end
					// MINUS
					else if ((i_SerialReady) && i_SerialData == 8'd45) begin
						o_YDirection = 1'b1;
					end
					// Y DATA COLLECTION
					else if ((i_SerialReady) && (i_SerialData != 8'd32) && (i_SerialData != 8'd13) && (i_SerialData != 8'd45)) begin
						o_YValue = o_YValue << 8;
						o_YValue[7:0] = i_SerialData;
					end
					else begin
						r_STATE = s_Y;
					end
				end
				s_Z: begin
					// SPACE
					if ((i_SerialReady) && i_SerialData == 8'd32) begin
						r_STATE = s_G;
					end
					// ENTER
					else if ((i_SerialReady) && i_SerialData == 8'd13) begin
						r_STATE = s_COMPLETE;
					end
					// MINUS
					else if ((i_SerialReady) && i_SerialData == 8'd45) begin
						o_ZDirection = 1'b1;
					end
					// Z DATA COLLECTION
					else if ((i_SerialReady) && (i_SerialData != 8'd32) && (i_SerialData != 8'd13) && (i_SerialData != 8'd45)) begin
						o_ZValue = o_ZValue << 8;
						o_ZValue[7:0] = i_SerialData;
					end
					else begin
						r_STATE = s_Z;
					end
				end
				s_E: begin
					// SPACE
					if ((i_SerialReady) && i_SerialData == 8'd32) begin
						r_STATE = s_G;
					end
					// ENTER
					else if ((i_SerialReady) && i_SerialData == 8'd13) begin
						r_STATE = s_COMPLETE;
					end
					// MINUS
					else if ((i_SerialReady) && i_SerialData == 8'd45) begin
						o_EDirection = 1'b1;
					end
					// X DATA COLLECTION
					else if ((i_SerialReady) && (i_SerialData != 8'd32) && (i_SerialData != 8'd13) && (i_SerialData != 8'd45)) begin
						o_EValue = o_EValue << 8;
						o_EValue[7:0] = i_SerialData;
					end
					else begin
						r_STATE = s_E;
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
	
	assign o_STATE = r_STATE;
	
endmodule
