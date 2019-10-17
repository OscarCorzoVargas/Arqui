//=======================================================
//  MODULE Definition
//=======================================================
module MAIN_MEMORY(
	//////////// OUTPUTS //////////
	MAIN_MEMORY_data_OutBUS,
	MAIN_MEMORY_ACK,
	//////////// INPUTS //////////
	MAIN_MEMORY_data_InBUS,
	MAIN_MEMORY_ADDRESS_data_InBUS,
	MAIN_MEMORY_RD_data_In,	
	MAIN_MEMORY_WR_data_In,
	MAIN_MEMORY_CLOCK_50
);
//=======================================================
//  PARAMETER declarations
//=======================================================
parameter DATAWIDTH_BUS = 32;
//=======================================================
//  PORT declarations
//=======================================================
output reg	[DATAWIDTH_BUS-1:0] MAIN_MEMORY_data_OutBUS;
output reg	MAIN_MEMORY_ACK;
input			[DATAWIDTH_BUS-1:0] MAIN_MEMORY_data_InBUS;
input			[DATAWIDTH_BUS-1:0] MAIN_MEMORY_ADDRESS_data_InBUS;
input			 MAIN_MEMORY_RD_data_In;	
input			 MAIN_MEMORY_WR_data_In;
input			 MAIN_MEMORY_CLOCK_50;
//=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
//PEGAR LOS BITS DE INSTRUCCIONES PARA QUE COMPILE
always@(*)
begin
	case (MAIN_MEMORY_ADDRESS_data_InBUS)	
		12'b100000000000: MAIN_MEMORY_data_OutBUS = 32'b10 00001 000010 00000 1 0000000000000;		//mov 0, %r1
		12'b100000000100: MAIN_MEMORY_data_OutBUS = 32'b10 00010 000010 00000 1 0000000000001;		//mov 1, %r2
		12'b100000001000: MAIN_MEMORY_data_OutBUS = 32'b10 00011 000010 00000 1 0000000000011;		//mov 3 (cambiable), %r3
		12'b100000001100: MAIN_MEMORY_data_OutBUS = 32'b00 0 1000 0100000000000000000000100;		//ba ld_sb
		12'b100000010000: MAIN_MEMORY_data_OutBUS = 32'b10 00001 000000 00001 0 00000000 00010;	//add %r1, %r2, %r1
		12'b100000010100: MAIN_MEMORY_data_OutBUS = 32'b10 00011 010000 00011 1 1111111111111;		//addcc %r3, -1, %r3
		12'b100000011000: MAIN_MEMORY_data_OutBUS = 32'b00 0 0001 010 0000000000000000000110;		//be endSim
		12'b100000011100: MAIN_MEMORY_data_OutBUS = 32'b00 0 1000 010 0000000000000000000001;		//ba F2
		12'b100000100000: MAIN_MEMORY_data_OutBUS = 32'b10 00010 010000 00001 0 00000000 00010;	//add %r1, %r2, %r2
		12'b100000100100: MAIN_MEMORY_data_OutBUS = 32'b10 00011 010000 00011 1 1111111111111;		//addcc %r3, -1, %r3
		12'b100000101000: MAIN_MEMORY_data_OutBUS = 32'b00 0 0001 010 0000000000000000000010;		//be endSim
		12'b100000101100: MAIN_MEMORY_data_OutBUS = 32'b00 0 1000 010 1011111111111111111001;		//ba ld_sb
		12'b100000110000: MAIN_MEMORY_data_OutBUS = 32'b11 11111 111111 11111 1 1111111111111;		//endSim: halt
		default :   MAIN_MEMORY_data_OutBUS = 32'b00 0 0000 000 0000000000000000000000; 	//NADA
	endcase
end
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL

endmodule
