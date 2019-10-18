module CC_MUXX_BUS_64_TO_32(
	//////////// OUTPUTS //////////TH_B
	CC_MUX_data_OutBUS,
	//////////// INPUTS //////////
	CC_MUX_BUS_64_TO_32_InBUS_Main_Memory,
	CC_MUX_BUS_64_TO_32_ALU,
	CC_MUX_BUS_64_TO_32_RD
);
//=======================================================
//  PARAMETER declarations
//=======================================================
parameter DATAWIDTH_BUS = 32;
//=======================================================
//  PORT declarations
//=======================================================
output reg	[DATAWIDTH_BUS-1:0] CC_MUX_data_OutBUS;
input			[DATAWIDTH_BUS-1:0] CC_MUX_BUS_64_TO_32_InBUS_Main_Memory;
input			[DATAWIDTH_BUS-1:0] CC_MUX_BUS_64_TO_32_ALU;
input		   CC_MUX_BUS_64_TO_32_RD;

//=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
always@(*)
begin
   if(CC_MUX_BUS_64_TO_32_RD==1'b0)
	
		CC_MUX_data_OutBUS = CC_MUX_BUS_64_TO_32_ALU;
		
	else
		
		CC_MUX_data_OutBUS = CC_MUX_BUS_64_TO_32_InBUS_Main_Memory;
	
end
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL

endmodule