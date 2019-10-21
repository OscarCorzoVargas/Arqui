//=======================================================
//  MODULE Definition
//=======================================================
module CS_MIR(
	//////////// OUTPUTS //////////
	CS_MIR_A_data_OutBUS,
	CS_MIR_AMUX_data_Out,
	CS_MIR_B_data_OutBUS,
	CS_MIR_BMUX_data_Out,
	CS_MIR_C_data_OutBUS,
	CS_MIR_CMUX_data_Out,
	CS_MIR_RD_data_Out,
	CS_MIR_WR_data_Out,
	CS_MIR_ALU_data_OutBUS,
	CS_MIR_COND_data_OutBUS,
	CS_MIR_ADDRESS_data_OutBUS,
	//////////// INPUTS //////////
	CS_MIR_CLOCK_50,
	CS_MIR_RESET_InHigh,
	CS_MIR_clear_InLow, 
	CS_MIR_load_InLow, 
	CS_MIR_INSTRUCTION_data_InBUS
);
//=======================================================
//  PARAMETER declarations
//=======================================================
parameter MIR_LENGTH_Reg = 6;
parameter MIR_LENGTH_ALU = 4;
parameter MIR_LENGTH_COND = 3;
parameter MIR_LENGTH_ADDR = 11;
parameter MIR_LENGTH_INSTR = 41;
//=======================================================
//  PORT declarations
//=======================================================
output		[MIR_LENGTH_Reg-1:0]	CS_MIR_A_data_OutBUS;
output		CS_MIR_AMUX_data_Out;
output		[MIR_LENGTH_Reg-1:0]	CS_MIR_B_data_OutBUS;
output		CS_MIR_BMUX_data_Out;
output		[MIR_LENGTH_Reg-1:0]	CS_MIR_C_data_OutBUS;
output		CS_MIR_CMUX_data_Out;
output		CS_MIR_RD_data_Out;
output		CS_MIR_WR_data_Out;
output		[MIR_LENGTH_Reg-1:0]	CS_MIR_ALU_data_OutBUS;
output		[MIR_LENGTH_Reg-1:0]	CS_MIR_COND_data_OutBUS;
output		[MIR_LENGTH_ADDR-1:0]	CS_MIR_ADDRESS_data_OutBUS;
input		CS_MIR_CLOCK_50;
input		CS_MIR_RESET_InHigh;
input		[MIR_LENGTH_INSTR-1:0]	CS_MIR_INSTRUCTION_data_InBUS;
input 	CS_MIR_clear_InLow;
input		CS_MIR_load_InLow;

//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [MIR_LENGTH_INSTR-1:0] CS_MIR_Register;
reg [MIR_LENGTH_INSTR-1:0] CS_MIR_Signal;
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always @(*)
begin
	CS_MIR_Signal = CS_MIR_INSTRUCTION_data_InBUS;
end	
//STATE REGISTER: SEQUENTIAL
always @(posedge CS_MIR_CLOCK_50, posedge CS_MIR_RESET_InHigh)
begin
	if (CS_MIR_RESET_InHigh == 1'b1)
		CS_MIR_Register <= 0;
	else
		CS_MIR_Register <= CS_MIR_Signal;
end
//=======================================================
//  Outputs
//=======================================================
//OUTPUT LOGIC: COMBINATIONAL
assign CS_MIR_A_data_OutBUS = CS_MIR_Register[40:35];
assign CS_MIR_AMUX_data_Out = CS_MIR_Register[34];
assign CS_MIR_B_data_OutBUS = CS_MIR_Register[33:28];
assign CS_MIR_BMUX_data_Out = CS_MIR_Register[27];
assign CS_MIR_C_data_OutBUS = CS_MIR_Register[26:21];
assign CS_MIR_CMUX_data_Out = CS_MIR_Register[20];
assign CS_MIR_RD_data_Out = CS_MIR_Register[19];
assign CS_MIR_WR_data_Out = CS_MIR_Register[18];
assign CS_MIR_ALU_data_OutBUS = CS_MIR_Register[17:14];
assign CS_MIR_COND_data_OutBUS = CS_MIR_Register[13:11];
assign CS_MIR_ADDRESS_data_OutBUS = CS_MIR_Register[10:0];
endmodule
