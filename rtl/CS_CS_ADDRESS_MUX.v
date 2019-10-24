//=======================================================
//  MODULE Definition
//=======================================================
module CS_CS_ADDRESS_MUX(
	//////////// OUTPUTS //////////
	CS_CS_ADDRESS_MUX_data_OutBUS,
	//////////// INPUTS //////////
	CS_CS_ADDRESS_MUX_data_CSAI,
	CS_CS_ADDRESS_MUX_data_MIR,
	CS_CS_ADDRESS_MUX_data_Scratchpad,	
	CS_CS_ADDRESS_MUX_data_Uno,	
	CS_CS_ADDRESS_MUX_data_CeroUno,	
	CS_CS_ADDRESS_MUX_data_CeroDos,	
	CS_CS_ADDRESS_MUX_selection_InBUS
);
//=======================================================
//  PARAMETER declarations
//=======================================================
parameter ADDR_LENGTH = 11;
parameter DECODER_LENGTH = 8;
parameter SELECTION_LENGTH = 2;
//=======================================================
//  PORT declarations
//=======================================================
output reg	[ADDR_LENGTH-1:0] CS_CS_ADDRESS_MUX_data_OutBUS;
input			[ADDR_LENGTH-1:0] CS_CS_ADDRESS_MUX_data_CSAI;
input			[ADDR_LENGTH-1:0] CS_CS_ADDRESS_MUX_data_MIR;
input			[DECODER_LENGTH-1:0] CS_CS_ADDRESS_MUX_data_Scratchpad;
input			 CS_CS_ADDRESS_MUX_data_Uno;	
input			 CS_CS_ADDRESS_MUX_data_CeroUno;
input			 CS_CS_ADDRESS_MUX_data_CeroDos;
input			[SELECTION_LENGTH-1:0] CS_CS_ADDRESS_MUX_selection_InBUS;
//=======================================================
//  REG/WIRE declarations
//=======================================================
//reg			[ADDR_LENGTH-1:0] ADDRESS_DECODER;
//always@(*)
//begin
//	case(CS_CS_ADDRESS_MUX_data_Scratchpad[7:6])
//		2'b00: ADDRESS_DECODER = {CS_CS_ADDRESS_MUX_data_Uno, CS_CS_ADDRESS_MUX_data_Scratchpad[7:3], 5b'00000};
//		default : ADDRESS_DECODER = {CS_CS_ADDRESS_MUX_data_Uno, CS_CS_ADDRESS_MUX_data_Scratchpad, CS_CS_ADDRESS_MUX_data_CeroUno, CS_CS_ADDRESS_MUX_data_CeroDos};
//	endcase
//end
// assign ADDRESS_DECODER = {CS_CS_ADDRESS_MUX_data_Uno, CS_CS_ADDRESS_MUX_data_Scratchpad, CS_CS_ADDRESS_MUX_data_CeroUno, CS_CS_ADDRESS_MUX_data_CeroDos};
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always@(*)
begin
	case (CS_CS_ADDRESS_MUX_selection_InBUS)	
		2'b00: CS_CS_ADDRESS_MUX_data_OutBUS = CS_CS_ADDRESS_MUX_data_CSAI;
		2'b01: CS_CS_ADDRESS_MUX_data_OutBUS = CS_CS_ADDRESS_MUX_data_MIR;
		2'b10: begin 
			if (CS_CS_ADDRESS_MUX_data_Scratchpad[7:6]==2'b00) begin
				CS_CS_ADDRESS_MUX_data_OutBUS = {CS_CS_ADDRESS_MUX_data_Uno, CS_CS_ADDRESS_MUX_data_Scratchpad[7:3], 5'b00000};
				end
			else 
				begin
					CS_CS_ADDRESS_MUX_data_OutBUS = {CS_CS_ADDRESS_MUX_data_Uno, CS_CS_ADDRESS_MUX_data_Scratchpad, CS_CS_ADDRESS_MUX_data_CeroUno, CS_CS_ADDRESS_MUX_data_CeroDos};
				end
			end
		default :   CS_CS_ADDRESS_MUX_data_OutBUS = CS_CS_ADDRESS_MUX_data_MIR; 
	endcase
end
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL

endmodule
