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
//INPUT LOGIC: COMBINATIONAL ... PEGAR LOS BITS
always@(*)
begin
	case (MAIN_MEMORY_ADDRESS_data_InBUS)	
		4'b0000: MAIN_MEMORY_data_OutBUS = 32'b10 00001 000010 00000 1 0000000000000;		//mov 0, %r1
		4'b0001: MAIN_MEMORY_data_OutBUS = 32'b10 00010 000010 00000 1 0000000000001;		//mov 1, %r2
		4'b0010: MAIN_MEMORY_data_OutBUS = 32'b10 00011 000010 00000 1 0000000000011;		//mov 3 (cambiable), %r3
		4'b0011: MAIN_MEMORY_data_OutBUS = 32'b00 0 1000 0100000000000000000000100;		//ba ld_sb
		4'b0100: MAIN_MEMORY_data_OutBUS = 32'b10 00001 000000 00001 0 00000000 00010;	//add %r1, %r2, %r1
		4'b0101: MAIN_MEMORY_data_OutBUS = 32'b10 00011 000100 10011 1 0000000000001;		//subcc %r3, 1, %r3
		4'b0110: MAIN_MEMORY_data_OutBUS = 32'b00 0 1001 010 0000000000000000000010;		//bne F2
		4'b0111: MAIN_MEMORY_data_OutBUS = 32'b00 0 1000 010 0000000000000000001100;		//ba endSim
		4'b1000: MAIN_MEMORY_data_OutBUS = 32'b10 00010 010000 00001 0 00000000 00010;	//add %r1, %r2, %r2
		4'b1001: MAIN_MEMORY_data_OutBUS = 32'b10 00011 000100 10011 1 0000000000001;		//subcc %r3, 1, %r3
		4'b1010: MAIN_MEMORY_data_OutBUS = 32'b00 0 1001 010 1111111111111111111010;		//bne %r3, 1, %r3
		4'b1011: MAIN_MEMORY_data_OutBUS = 32'b00 0 1000 010 0000000000000000001100;		//ba endSim
		4'b1100: MAIN_MEMORY_data_OutBUS = 32'b11 11111 111111 11111 1 1111111111111;		//endSim: halt
		default :   MAIN_MEMORY_data_OutBUS = 32'b00 0 0000 000 0000000000000000000000; 	//NADA
	endcase
end
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL

endmodule
