//=======================================================
//  MODULE Definition
//=======================================================
module CS_CSAI(
	//////////// OUTPUTS //////////
	CS_CSAI_data_OutBUS,
	//////////// INPUTS //////////
	CS_CSAI_JUMP_ADDR,
	CS_CSAI_ACK,
	CS_CSAI_RESET,
	CS_CSAI_CLOCK_50
);
//=======================================================
//  PARAMETER declarations
//=======================================================
parameter CSAI_LENGTH_ADDR = 11;
//=======================================================
//  PORT declarations
//=======================================================
output [CSAI_LENGTH_ADDR-1:0] CS_CSAI_data_OutBUS;
input [CSAI_LENGTH_ADDR-1:0] CS_CSAI_JUMP_ADDR;
input CS_CSAI_ACK;
input CS_CSAI_RESET;
input CS_CSAI_CLOCK_50;
//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [CSAI_LENGTH_ADDR-1:0] CSAI_Register;
reg [CSAI_LENGTH_ADDR-1:0] CSAI_Signal;
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always @(*)
begin
//	if (CS_CSAI_ACK == 1'b1)
		CSAI_Signal = CS_CSAI_JUMP_ADDR + 11'b00000000001;
//	else
//		CSAI_Signal = CSAI_Register;
	end	
//STATE REGISTER: SEQUENTIAL
always @(posedge CS_CSAI_CLOCK_50, posedge CS_CSAI_RESET)
begin
	if (CS_CSAI_RESET == 1'b1)
		CSAI_Register <= 0;
	else
		CSAI_Register <= CSAI_Signal;
end
//=======================================================
//  Outputs
//=======================================================
//OUTPUT LOGIC: COMBINATIONAL
assign CS_CSAI_data_OutBUS = CSAI_Register;

endmodule