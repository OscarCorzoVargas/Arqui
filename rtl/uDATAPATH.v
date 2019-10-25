//=======================================================
//  MODULE Definition
//=======================================================
module uDATAPATH #(parameter DATAWIDTH_BUS=32, parameter DATAWIDTH_DECODER_SELECTION=4, parameter DATAWIDTH_DECODER_OUT=12, parameter DATAWIDTH_ALU_SELECTION=4, parameter DATAWIDTH_MUX_SELECTION=4, parameter DATA_REGFIXED_INIT_0=8'b00001001, parameter DATA_REGFIXED_INIT_1=8'b00001111, parameter DATA_BUS_CONTROL=6)(
	//////////// OUTPUTS //////////
	uDATAPATH_data_OutBUS,
	uDATAPATH_overflow_OutLow,
	uDATAPATH_carry_OutLow,
	uDATAPATH_negative_OutLow,
	uDATAPATH_zero_OutLow,
	uDATAPATH_Habilitador_PSR,
	uDATAPATH_Registro_IR,
	uDATAPATH_BUS_A,
	uDATAPATH_BUS_B,
	//////////// INPUTS //////////
	uDATAPATH_CLOCK_50,
	uDATAPATH_RESET_InHigh,
	uDATAPATH_decoderclearselection_InBUS,
	uDATAPATH_decoderloadselection_InBUS,
	uDATAPATH_aluselection_InBUS,
	uDATAPATH_regSHIFTERclear_InLow,
	uDATAPATH_regSHIFTERload_InLow,
	uDATAPATH_regSHIFTERshiftselection_InLow,
	uDATAPATH_BUS_CONTROL_A,
	uDATAPATH_BUS_CONTROL_B,
	uDATAPATH_BUS_CONTROL_C,
	uDATAPATH_BUS_SELECTOR_A,
	uDATAPATH_BUS_SELECTOR_B,
	uDATAPATH_BUS_SELECTOR_C,
	uDATAPATH_BUS_C
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
output 	[DATAWIDTH_BUS-1:0]	uDATAPATH_data_OutBUS;
output 	uDATAPATH_overflow_OutLow;
output 	uDATAPATH_carry_OutLow;
output 	uDATAPATH_negative_OutLow;
output 	uDATAPATH_zero_OutLow;
output	uDATAPATH_Habilitador_PSR;
output 	[DATAWIDTH_BUS-1:0]uDATAPATH_Registro_IR;
output	[DATAWIDTH_BUS-1:0]uDATAPATH_BUS_A;
output	[DATAWIDTH_BUS-1:0]uDATAPATH_BUS_B;

//////////// INPUTS //////////
input 	uDATAPATH_CLOCK_50;
input 	uDATAPATH_RESET_InHigh;
input 	[DATAWIDTH_DECODER_SELECTION-1:0]	uDATAPATH_decoderclearselection_InBUS;
input 	[DATAWIDTH_DECODER_SELECTION-1:0]	uDATAPATH_decoderloadselection_InBUS;
input 	[DATAWIDTH_ALU_SELECTION-1:0]	uDATAPATH_aluselection_InBUS;
input		uDATAPATH_regSHIFTERclear_InLow;
input 	uDATAPATH_regSHIFTERload_InLow;
input 	[1:0] uDATAPATH_regSHIFTERshiftselection_InLow;
input 	[DATA_BUS_CONTROL-1:0] uDATAPATH_BUS_CONTROL_A;
input	 	[DATA_BUS_CONTROL-1:0] uDATAPATH_BUS_CONTROL_B;
input 	[DATA_BUS_CONTROL-1:0] uDATAPATH_BUS_CONTROL_C;
input 	uDATAPATH_BUS_SELECTOR_A;
input 	uDATAPATH_BUS_SELECTOR_B;
input 	uDATAPATH_BUS_SELECTOR_C;
input 	[DATAWIDTH_BUS-1:0] uDATAPATH_BUS_C;

//=======================================================
//  REG/WIRE declarations
//=======================================================
// GENERAL_REGISTERS OUTPUTS WIRES
wire [DATAWIDTH_BUS-1:0] RegGENERAL_2_MUX_data0_wireBUS_A; 
wire [DATAWIDTH_BUS-1:0] RegGENERAL_2_MUX_data1_wireBUS_A; 
wire [DATAWIDTH_BUS-1:0] RegGENERAL_2_MUX_data2_wireBUS_A; 
wire [DATAWIDTH_BUS-1:0] RegGENERAL_2_MUX_data3_wireBUS_A;
wire [DATAWIDTH_BUS-1:0] RegGENERAL_2_MUX_data0_wireBUS_B; 
wire [DATAWIDTH_BUS-1:0] RegGENERAL_2_MUX_data1_wireBUS_B; 
wire [DATAWIDTH_BUS-1:0] RegGENERAL_2_MUX_data2_wireBUS_B; 
wire [DATAWIDTH_BUS-1:0] RegGENERAL_2_MUX_data3_wireBUS_B;
// FIXED_REGISTERS OUTPUTS WIRES
wire [DATAWIDTH_BUS-1:0] RegFIXED_2_MUX_data0_wireBUS; 
wire [DATAWIDTH_BUS-1:0] RegFIXED_2_MUX_data1_wireBUS; 
// ARCHITECTURE BUSES WIRES
wire [DATAWIDTH_BUS-1:0] MUX_2_ALU_dataA_wireBUS;
wire [DATAWIDTH_BUS-1:0] MUX_2_ALU_dataB_wireBUS; 
wire [DATAWIDTH_BUS-1:0] ALU_2_RegSHIFTER_data_wireBUS;
wire [DATAWIDTH_BUS-1:0] RegSHIFTER_2_RegGENERAL_dataC_wireBUS;
// DECODER CONTROL CLEAR
wire [DATAWIDTH_DECODER_OUT-1:0] DECODER_2_RegGENERAL_decoderclearselection_wireBUS;
// DECODER CONTROL LOAD
wire [DATAWIDTH_DECODER_OUT-1:0] DECODER_2_RegGENERAL_decoderloadselection_wireBUS;
wire [DATAWIDTH_DECODER_OUT-1:0] DECODER_A;
wire [DATAWIDTH_DECODER_OUT-1:0] DECODER_B;
wire [DATA_BUS_CONTROL-1:0] CONTROL_C;
wire [DATA_BUS_CONTROL-1:0] CONTROL_B;
wire [DATA_BUS_CONTROL-1:0] CONTROL_A;
wire [DATA_BUS_CONTROL-2:0] IR_A;
wire [DATA_BUS_CONTROL-2:0] IR_B;
wire [DATA_BUS_CONTROL-2:0] IR_C;
wire [DATAWIDTH_BUS-1:0]RegGENERAL_2_MUX_dataIR_wireBUS_A;
wire [DATAWIDTH_BUS-1:0]RegGENERAL_2_MUX_dataIR_wireBUS_B;
wire [DATAWIDTH_BUS-1:0]RegGENERAL_2_MUX_dataIR_wireBUS_C;
wire [DATAWIDTH_DECODER_SELECTION-1:0]	uDATAPATH_DECODERA_InBUS;
wire [DATAWIDTH_DECODER_SELECTION-1:0]	uDATAPATH_DECODERB_InBUS;
wire [DATAWIDTH_DECODER_SELECTION-1:0]	uDATAPATH_DECODERC_InBUS;

// CABLES PARA TEMP 0
wire [DATAWIDTH_BUS-1:0] RegGENERAL_2_MUX_Temp0_wireBUS_A;
wire [DATAWIDTH_BUS-1:0] RegGENERAL_2_MUX_Temp0_wireBUS_B;

//	CABLES PARA %PC
wire [DATAWIDTH_BUS-1:0]RegGENERAL_2_MUX_dataPC_wireBUS_A;
wire [DATAWIDTH_BUS-1:0]RegGENERAL_2_MUX_dataPC_wireBUS_B;

//	CABLES PARA %RS
wire [DATAWIDTH_BUS-1:0]RegGENERAL_2_MUX_dataRS_wireBUS_A;
wire [DATAWIDTH_BUS-1:0]RegGENERAL_2_MUX_dataRS_wireBUS_B;
	//=======================================================
//  Structural coding
//=======================================================

//-------------------------------------------------------
//GENERAL_REGISTERS
SC_RegGENERAL #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) SC_R0 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_data_OutBUS_A(RegGENERAL_2_MUX_data0_wireBUS_A),
	.SC_RegGENERAL_data_OutBUS_B(RegGENERAL_2_MUX_data0_wireBUS_B),
	.SC_RegGENERAL_CLOCK_50(uDATAPATH_CLOCK_50),
	.SC_RegGENERAL_RESET_InHigh(uDATAPATH_RESET_InHigh),
	.SC_RegGENERAL_clear_InLow(DECODER_2_RegGENERAL_decoderclearselection_wireBUS[0]),
	.SC_RegGENERAL_DecoC_InLow(DECODER_2_RegGENERAL_decoderloadselection_wireBUS[0]),
	.SC_RegGENERAL_data_InBUS(uDATAPATH_BUS_C)
);
SC_RegGENERAL #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) SC_R1 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_data_OutBUS_A(RegGENERAL_2_MUX_data1_wireBUS_A),
	.SC_RegGENERAL_data_OutBUS_B(RegGENERAL_2_MUX_data1_wireBUS_B),
	.SC_RegGENERAL_CLOCK_50(uDATAPATH_CLOCK_50),
	.SC_RegGENERAL_RESET_InHigh(uDATAPATH_RESET_InHigh),
	.SC_RegGENERAL_clear_InLow(DECODER_2_RegGENERAL_decoderclearselection_wireBUS[1]),
	.SC_RegGENERAL_DecoC_InLow(DECODER_2_RegGENERAL_decoderloadselection_wireBUS[1]),
	.SC_RegGENERAL_data_InBUS(uDATAPATH_BUS_C)
);
SC_RegGENERAL #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) SC_R2 (
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_data_OutBUS_A(RegGENERAL_2_MUX_data2_wireBUS_A),
	.SC_RegGENERAL_data_OutBUS_B(RegGENERAL_2_MUX_data2_wireBUS_B),
	.SC_RegGENERAL_CLOCK_50(uDATAPATH_CLOCK_50),
	.SC_RegGENERAL_RESET_InHigh(uDATAPATH_RESET_InHigh),
	.SC_RegGENERAL_clear_InLow(DECODER_2_RegGENERAL_decoderclearselection_wireBUS[2]),
	.SC_RegGENERAL_DecoC_InLow(DECODER_2_RegGENERAL_decoderloadselection_wireBUS[2]),
	.SC_RegGENERAL_data_InBUS(uDATAPATH_BUS_C)
);
SC_RegGENERAL #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) SC_R3(
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_data_OutBUS_A(RegGENERAL_2_MUX_data3_wireBUS_A),
	.SC_RegGENERAL_data_OutBUS_B(RegGENERAL_2_MUX_data3_wireBUS_B),
	.SC_RegGENERAL_CLOCK_50(uDATAPATH_CLOCK_50),
	.SC_RegGENERAL_RESET_InHigh(uDATAPATH_RESET_InHigh),
	.SC_RegGENERAL_clear_InLow(DECODER_2_RegGENERAL_decoderclearselection_wireBUS[3]),
	.SC_RegGENERAL_DecoC_InLow(DECODER_2_RegGENERAL_decoderloadselection_wireBUS[3]),
	.SC_RegGENERAL_data_InBUS(uDATAPATH_BUS_C)
);
SC_RegGENERAL #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) SC_RS(
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_data_OutBUS_A(RegGENERAL_2_MUX_dataRS_wireBUS_A),
	.SC_RegGENERAL_data_OutBUS_B(RegGENERAL_2_MUX_dataRS_wireBUS_B),
	.SC_RegGENERAL_CLOCK_50(uDATAPATH_CLOCK_50),
	.SC_RegGENERAL_RESET_InHigh(uDATAPATH_RESET_InHigh),
	.SC_RegGENERAL_clear_InLow(DECODER_2_RegGENERAL_decoderclearselection_wireBUS[3]),
	.SC_RegGENERAL_DecoC_InLow(DECODER_2_RegGENERAL_decoderloadselection_wireBUS[4]),
	.SC_RegGENERAL_data_InBUS(uDATAPATH_BUS_C)
);
SC_RegGENERAL #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) SC_PC(
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_data_OutBUS_A(RegGENERAL_2_MUX_dataPC_wireBUS_A),
	.SC_RegGENERAL_data_OutBUS_B(RegGENERAL_2_MUX_dataPC_wireBUS_B),
	.SC_RegGENERAL_CLOCK_50(uDATAPATH_CLOCK_50),
	.SC_RegGENERAL_RESET_InHigh(uDATAPATH_RESET_InHigh),
	.SC_RegGENERAL_clear_InLow(DECODER_2_RegGENERAL_decoderclearselection_wireBUS[3]),
	.SC_RegGENERAL_DecoC_InLow(DECODER_2_RegGENERAL_decoderloadselection_wireBUS[5]),
	.SC_RegGENERAL_data_InBUS(uDATAPATH_BUS_C)
);
SC_RegGENERAL #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) SC_IR(
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_data_OutBUS_A(RegGENERAL_2_MUX_dataIR_wireBUS_A),
	.SC_RegGENERAL_data_OutBUS_B(uDATAPATH_Registro_IR),
	.SC_RegGENERAL_CLOCK_50(uDATAPATH_CLOCK_50),
	.SC_RegGENERAL_RESET_InHigh(uDATAPATH_RESET_InHigh),
	.SC_RegGENERAL_clear_InLow(DECODER_2_RegGENERAL_decoderclearselection_wireBUS[3]),
	.SC_RegGENERAL_DecoC_InLow(DECODER_2_RegGENERAL_decoderloadselection_wireBUS[6]),
	.SC_RegGENERAL_data_InBUS(uDATAPATH_BUS_C)
);

SC_RegGENERAL #(.RegGENERAL_DATAWIDTH(DATAWIDTH_BUS)) SC_Temp0(
// port map - connection between master ports and signals/registers   
	.SC_RegGENERAL_data_OutBUS_A(RegGENERAL_2_MUX_Temp0_wireBUS_A),
	.SC_RegGENERAL_data_OutBUS_B(RegGENERAL_2_MUX_Temp0_wireBUS_B),
	.SC_RegGENERAL_CLOCK_50(uDATAPATH_CLOCK_50),
	.SC_RegGENERAL_RESET_InHigh(uDATAPATH_RESET_InHigh),
	.SC_RegGENERAL_clear_InLow(DECODER_2_RegGENERAL_decoderclearselection_wireBUS[3]),
	.SC_RegGENERAL_DecoC_InLow(DECODER_2_RegGENERAL_decoderloadselection_wireBUS[7]),
	.SC_RegGENERAL_data_InBUS(uDATAPATH_BUS_C)
);

CC_DECODER #(.DATAWIDTH_DECODER_SELECTION(DATAWIDTH_DECODER_SELECTION), .DATAWIDTH_DECODER_OUT(DATAWIDTH_DECODER_OUT)) CC_DECODER_CLEAR
(
// port map - connection between master ports and signals/registers   
	.CC_DECODER_datadecoder_OutBUS(DECODER_2_RegGENERAL_decoderclearselection_wireBUS),
	.CC_DECODER_selection_InBUS(uDATAPATH_decoderclearselection_InBUS)
);
// 
CC_DECODER #(.DATAWIDTH_DECODER_SELECTION(DATAWIDTH_DECODER_SELECTION), .DATAWIDTH_DECODER_OUT(DATAWIDTH_DECODER_OUT)) CC_DECODER_C
(
// port map - connection between master ports and signals/registers   
	.CC_DECODER_datadecoder_OutBUS(DECODER_2_RegGENERAL_decoderloadselection_wireBUS),
	.CC_DECODER_selection_InBUS(uDATAPATH_DECODERC_InBUS)
);

//-------------------------------------------------------
//-------------------------------------------------------
// 
CC_MUXX #(.DATAWIDTH_MUX_SELECTION(DATAWIDTH_MUX_SELECTION), .DATAWIDTH_BUS(DATAWIDTH_BUS)) CC_MUXX_BusA
(
// port map - connection between master ports and signals/registers   
	.CC_MUX_data_OutBUS(uDATAPATH_BUS_A),
	.CC_MUX_data0_InBUS(RegGENERAL_2_MUX_data0_wireBUS_A), 
	.CC_MUX_data1_InBUS(RegGENERAL_2_MUX_data0_wireBUS_A), 
	.CC_MUX_data2_InBUS(RegGENERAL_2_MUX_data1_wireBUS_A), 
	.CC_MUX_data3_InBUS(RegGENERAL_2_MUX_data2_wireBUS_A), 
	.CC_MUX_data4_InBUS(RegGENERAL_2_MUX_data3_wireBUS_A), 
	.CC_MUX_data5_InBUS(RegGENERAL_2_MUX_dataRS_wireBUS_A),
	.CC_MUX_data6_InBUS(RegGENERAL_2_MUX_dataPC_wireBUS_A), //REPEATED BUT MUST CHANGE
	.CC_MUX_data7_InBUS(RegGENERAL_2_MUX_dataIR_wireBUS_A), //REPEATED BUT MUST CHANGE
	.CC_MUX_data8_InBUS(RegGENERAL_2_MUX_Temp0_wireBUS_A),
	.CC_MUX_selection_InBUS(uDATAPATH_DECODERA_InBUS)

);
//// 
CC_MUXX #(.DATAWIDTH_MUX_SELECTION(DATAWIDTH_MUX_SELECTION), .DATAWIDTH_BUS(DATAWIDTH_BUS)) CC_MUXX_BusB
(
// port map - connection between master ports and signals/registers   
	.CC_MUX_data_OutBUS(uDATAPATH_BUS_B),
	.CC_MUX_data0_InBUS(RegGENERAL_2_MUX_data0_wireBUS_B), 
	.CC_MUX_data1_InBUS(RegGENERAL_2_MUX_data0_wireBUS_B), 
	.CC_MUX_data2_InBUS(RegGENERAL_2_MUX_data1_wireBUS_B), 
	.CC_MUX_data3_InBUS(RegGENERAL_2_MUX_data2_wireBUS_B), 
	.CC_MUX_data4_InBUS(RegGENERAL_2_MUX_data3_wireBUS_B), 
	.CC_MUX_data5_InBUS(RegGENERAL_2_MUX_dataRS_wireBUS_B),
	.CC_MUX_data6_InBUS(RegGENERAL_2_MUX_dataPC_wireBUS_B), //REPEATED BUT MUST CHANGE
	.CC_MUX_data7_InBUS(uDATAPATH_Registro_IR), //REPEATED BUT MUST CHANGE
	.CC_MUX_data8_InBUS(RegGENERAL_2_MUX_Temp0_wireBUS_B),
	.CC_MUX_selection_InBUS(uDATAPATH_DECODERB_InBUS)
);
//-------------------------------------------------------
//-------------------------------------------------------
//
CC_ALU #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATAWIDTH_ALU_SELECTION(DATAWIDTH_ALU_SELECTION)) CC_ALU_u0
(
// port map - connection between master ports and signals/registers   
	.CC_ALU_overflow_OutLow(uDATAPATH_overflow_OutLow), 
	.CC_ALU_carry_OutLow(uDATAPATH_carry_OutLow), 
	.CC_ALU_negative_OutLow(uDATAPATH_negative_OutLow), 
	.CC_ALU_zero_OutLow(uDATAPATH_zero_OutLow),
	.Set_Conditions_Code(uDATAPATH_Habilitador_PSR),
	.CC_ALU_data_OutBUS(uDATAPATH_data_OutBUS),
	.CC_ALU_dataA_InBUS(uDATAPATH_BUS_A), 
	.CC_ALU_dataB_InBUS(uDATAPATH_BUS_B),
	.CC_ALU_selection_InBUS(uDATAPATH_aluselection_InBUS)
);
//-------------------------------------------------------
//assign uDATAPATH_data_OutBUS = RegGENERAL_2_MUX_data3_wireBUS_A;
CC_MUXX_BUS #(.DATAWIDTH_MUX_SELECTION_REG(5), .DATAWIDTH_MUX_SELECTION_CONTROL(6), .DATAWIDTH_BUS(4)) CC_MUXX_REG_A(
	.CC_MUX_registro_InBUS(RegGENERAL_2_MUX_dataIR_wireBUS_A[18:14]),
	.CC_MUX_control_InBUS(uDATAPATH_BUS_CONTROL_A),
	.CC_MUX_selector_InBUS(uDATAPATH_BUS_SELECTOR_A),
	.CC_MUX_data_OutBUS(uDATAPATH_DECODERA_InBUS)
);

CC_MUXX_BUS #(.DATAWIDTH_MUX_SELECTION_REG(5), .DATAWIDTH_MUX_SELECTION_CONTROL(6), .DATAWIDTH_BUS(4)) CC_MUXX_REG_B(
	.CC_MUX_registro_InBUS(uDATAPATH_Registro_IR[4:0]),
	.CC_MUX_control_InBUS(uDATAPATH_BUS_CONTROL_B),
	.CC_MUX_selector_InBUS(uDATAPATH_BUS_SELECTOR_B),
	.CC_MUX_data_OutBUS(uDATAPATH_DECODERB_InBUS)
);

CC_MUXX_BUS #(.DATAWIDTH_MUX_SELECTION_REG(5), .DATAWIDTH_MUX_SELECTION_CONTROL(6), .DATAWIDTH_BUS(4)) CC_MUXX_REG_C(
	.CC_MUX_registro_InBUS(uDATAPATH_Registro_IR[29:25]),
	.CC_MUX_control_InBUS(uDATAPATH_BUS_CONTROL_C),
	.CC_MUX_selector_InBUS(uDATAPATH_BUS_SELECTOR_C),
	.CC_MUX_data_OutBUS(uDATAPATH_DECODERC_InBUS)
);

endmodule

