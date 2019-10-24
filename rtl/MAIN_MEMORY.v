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
always@(*)
begin
	if (MAIN_MEMORY_RD_data_In == 1'b1)
		case (MAIN_MEMORY_ADDRESS_data_InBUS)	
			
			12'b000000000000: MAIN_MEMORY_data_OutBUS = 32'b00010000100000000000100000000000;		//ba ld_sb
			//12'b100000000000: MAIN_MEMORY_data_OutBUS = 32'b11000100000000000010000000000000;		//mov 0, %r1
			12'b100000000000: MAIN_MEMORY_data_OutBUS = 32'b11000110000000000010000000000001;		//mov 1, %r2             2048
			12'b100000000100: MAIN_MEMORY_data_OutBUS = 32'b11001000000000000010000000000100;		//mov 3 (cambiable), %r3 2052
			12'b100000001000: MAIN_MEMORY_data_OutBUS = 32'b00010000100000000000000000000100;		//ba ld_sb					 2056
			12'b100000001100: MAIN_MEMORY_data_OutBUS = 32'b10000100100000001000000000000011;		//addcc %r1, %r2, %r1	 2060
			12'b100000010000: MAIN_MEMORY_data_OutBUS = 32'b10001000100000010011111111111111;		//addcc %r3, -1, %r3		 2064
			12'b100000010100: MAIN_MEMORY_data_OutBUS = 32'b00000010100000000000000000011000;		//be endSim					 2068
			12'b100000011000: MAIN_MEMORY_data_OutBUS = 32'b00010000100000000000000000000100;		//ba F2						 2072
			12'b100000011100: MAIN_MEMORY_data_OutBUS = 32'b10000110100000001000000000000011;		//addcc %r1, %r2, %r2	 2076
			12'b100000100000: MAIN_MEMORY_data_OutBUS = 32'b10001000100000010011111111111111;		//addcc %r3, -1, %r3		 2080
			12'b100000100100: MAIN_MEMORY_data_OutBUS = 32'b00000010100000000000000000001000;		//be endSim					 2084
			12'b100000101000: MAIN_MEMORY_data_OutBUS = 32'b00010000101111111111111111100100;		//ba ld_sb					 2088
			12'b100000101100: MAIN_MEMORY_data_OutBUS = 32'b00010000100000000000000000000100;		//endSim: ba +4;			 2092
			12'b100000110000: MAIN_MEMORY_data_OutBUS = 32'b00010000101111111111111111111100;		//ba endSim					 2096
			default :   MAIN_MEMORY_data_OutBUS = MAIN_MEMORY_ADDRESS_data_InBUS; 				//MISMA ENTRADA
		endcase
	else
			MAIN_MEMORY_data_OutBUS = 32'B00000000000000000000000000000000; 
end

	
endmodule
